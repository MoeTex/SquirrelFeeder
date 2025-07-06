#include <HX711.h>
#include <AccelStepper.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

#define DT 18
#define SCK 19
HX711 scale;
const float KALIBRIERFAKTOR = -1053.4720;

#define STEP_PIN 26
#define DIR_PIN 27
AccelStepper stepper(AccelStepper::DRIVER, STEP_PIN, DIR_PIN);

#define SERVICE_UUID        "12345678-1234-1234-1234-1234567890ab"
#define CHARACTERISTIC_UUID "abcd1234-5678-90ab-cdef-1234567890ab"
BLECharacteristic *pCharacteristic;
bool deviceConnected = false;

float referenzGewicht = 0.0;          
float gewichtBeiLetztemTrigger = 0.0; 
bool motorTriggered = false;         
unsigned long letzteAktionZeit = 0;   

class MyServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) { deviceConnected = true; }
  void onDisconnect(BLEServer* pServer) { deviceConnected = false; }
};
class MyCallbacks : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {}
};

void setup() {
  Serial.begin(115200);
  delay(500);

  scale.begin(DT, SCK);
  delay(1000);
  if (!scale.is_ready()) {
    Serial.println("HX711 nicht bereit!");
    while (1);
  }
  scale.set_scale(KALIBRIERFAKTOR);
  scale.tare();                     
  referenzGewicht = scale.get_units(1); 
  Serial.print("Waage tariert & kalibriert. Initiales Referenzgewicht: ");
  Serial.print(referenzGewicht, 2);
  Serial.println(" g");

  stepper.setMaxSpeed(1000.0);
  stepper.setAcceleration(500.0);
  stepper.setCurrentPosition(0);

  BLEDevice::init("ESP32_BLE_DEVICE");
  BLEServer *pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  BLEService *pService = pServer->createService(SERVICE_UUID);
  pCharacteristic = pService->createCharacteristic(
                      CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_NOTIFY |
                      BLECharacteristic::PROPERTY_WRITE);
  pCharacteristic->addDescriptor(new BLE2902());
  pCharacteristic->setCallbacks(new MyCallbacks());

  pService->start();
  pServer->getAdvertising()->start();
  Serial.println("BLE gestartet. Warte auf Verbindungen...");
}

void loop() {
  float aktuellesGewicht = scale.get_units(1); 
  Serial.print("Aktuelles Gewicht: ");
  Serial.print(aktuellesGewicht, 2);
  Serial.println(" g");

  float diffVonReferenz = aktuellesGewicht - referenzGewicht;

  if (!motorTriggered && diffVonReferenz >= 200.0) {
    Serial.println("Positive Gewichtsänderung (+200g) erkannt! Motor startet.");
    

    if (deviceConnected) {
      String msg = "Gewicht erkannt: " + String(aktuellesGewicht, 1) + " g";
      pCharacteristic->setValue(msg.c_str());
      pCharacteristic->notify();
    }

 
    int steps = 1600;
    stepper.moveTo(stepper.currentPosition() + steps);
    while (stepper.distanceToGo() != 0) {
      stepper.run();
    }
    
    motorTriggered = true;          
    gewichtBeiLetztemTrigger = aktuellesGewicht; 
    letzteAktionZeit = millis();    
  }

  if (motorTriggered) {

    float diffVomTriggerGewicht = aktuellesGewicht - gewichtBeiLetztemTrigger;

    if (diffVomTriggerGewicht <= -180.0) { 

      if (millis() - letzteAktionZeit >= 2000) { 
        Serial.println("2 Sekunden abgelaufen. Gewicht um -180g oder mehr gefallen. Waage wird neu tariert.");
        scale.tare();
      
        referenzGewicht = scale.get_units(1);
        Serial.print("Neues Referenzgewicht nach Tare: ");
        Serial.print(referenzGewicht, 2);
        Serial.println(" g");
        
        motorTriggered = false;       
        gewichtBeiLetztemTrigger = 0.0;
        delay(1000);                  
      }
    } else {
      letzteAktionZeit = millis();
    }
  }
  delay(200); 
}