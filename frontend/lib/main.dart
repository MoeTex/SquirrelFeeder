import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'dart:typed_data'; // For Uint8List
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp; // Alias für flutter_blue_plus
import 'package:flutter_blue_plus/flutter_blue_plus.dart' show Guid; // Expliziter Import für Guid

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SquirrelWatch App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // Umweltfreundliche grüne Farbe
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Verwenden Sie die Schriftart Inter
        // Zusätzliche spielerische Typografie
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.lightGreen),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.lightGreen),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.green),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.green),
          bodySmall: TextStyle(fontSize: 12, color: Colors.green),
          labelLarge: TextStyle(fontSize: 14, color: Colors.green),
          labelMedium: TextStyle(fontSize: 12, color: Colors.green),
          labelSmall: TextStyle(fontSize: 11, color: Colors.green),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // Helper method to build a bullet point row
  Widget _buildBulletPoint(IconData icon, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50], // Sehr leichter Grünton für den Hintergrund
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Ein Bild, das die App repräsentiert, mit spielerischem Rahmen
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen[200],
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreen.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    'https://placehold.co/600x400/9CCC65/ffffff?text=Squirrel+Feeder+App',
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.lightGreen[700],
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.lightGreen[100],
                      child: const Icon(Icons.image_not_supported, size: 100, color: Colors.lightGreen),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Titel des Onboarding-Bildschirms
              Text(
                'Willkommen bei SquirrelWatch!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen[900],
                ),
              ),
              const SizedBox(height: 20),

              // Beschreibung der App
              Text(
                'Verbinden Sie sich mit Ihrem smarten Eichhörnchen-Futterautomaten, um Eichhörnchen-Aktivitäten zu beobachten, Fütterungsmuster zu verfolgen und wertvolle Daten zu sammeln.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 30),

              // Anweisungen zur Verbindung (Bullet Points)
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildBulletPoint(Icons.power_settings_new, '1. Stellen Sie sicher, dass Ihr Futterautomat eingeschaltet ist.', Colors.green[800]!),
                    const SizedBox(height: 10),
                    _buildBulletPoint(Icons.bluetooth, '2. Aktivieren Sie Bluetooth auf Ihrem Gerät.', Colors.green[800]!),
                    const SizedBox(height: 10),
                    _buildBulletPoint(Icons.link, '3. Tippen Sie auf "Jetzt starten & Verbinden", um die Kopplung zu beginnen.', Colors.green[800]!),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Call-to-Action-Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BluetoothScanScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightGreen[700],
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Jetzt starten & Verbinden',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// New Screen for Bluetooth Scanning
class BluetoothScanScreen extends StatefulWidget {
  const BluetoothScanScreen({super.key});

  @override
  State<BluetoothScanScreen> createState() => _BluetoothScanScreenState();
}

class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
  // Bluetooth-bezogene Zustände
  fbp.BluetoothAdapterState _adapterState = fbp.BluetoothAdapterState.unknown; // Alias verwendet
  final List<fbp.BluetoothDevice> _foundDevices = []; // Alias verwendet
  StreamSubscription<fbp.BluetoothAdapterState>? _adapterStateSubscription; // Alias verwendet
  StreamSubscription<List<fbp.ScanResult>>? _scanResultsSubscription; // Alias verwendet
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();

    // Überwachen des Bluetooth-Adapter-Zustands
    _adapterStateSubscription = fbp.FlutterBluePlus.adapterState.listen((state) {
      setState(() {
        _adapterState = state;
      });
      // Wenn der Adapter an ist, starte den Scan automatisch
      if (state == fbp.BluetoothAdapterState.on && !_isScanning) {
        _startScan();
      }
    });

    // Überwachen der Scan-Ergebnisse
    _scanResultsSubscription = fbp.FlutterBluePlus.scanResults.listen((results) {
      for (fbp.ScanResult result in results) {
        // Füge nur Geräte hinzu, die einen Namen haben und noch nicht in der Liste sind
        if (result.device.platformName.isNotEmpty && !_foundDevices.any((d) => d.remoteId == result.device.remoteId)) {
          setState(() {
            _foundDevices.add(result.device);
          });
        }
      }
    });

    // Überwachen des Scan-Status (ob ein Scan läuft)
    fbp.FlutterBluePlus.isScanning.listen((scanning) {
      setState(() {
        _isScanning = scanning;
      });
    });

    // Starte den Scan initial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScan();
    });
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _scanResultsSubscription?.cancel();
    fbp.FlutterBluePlus.stopScan();
    super.dispose();
  }

  // Funktion zum Starten des Bluetooth-Scans
  void _startScan() async {
    if (!mounted) return;

    if (_adapterState != fbp.BluetoothAdapterState.on) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bitte schalten Sie Bluetooth ein, um Geräte zu finden.'),
          backgroundColor: Colors.orange[600],
        ),
      );
      return;
    }

    if (_isScanning) {
      fbp.FlutterBluePlus.stopScan();
      await Future.delayed(const Duration(milliseconds: 500));
    }

    _foundDevices.clear();
    try {
      await fbp.FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 30),
      );
    } catch (e) {
      print("Fehler beim Starten des Scans: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler beim Starten des Bluetooth-Scans: ${e.toString().split(':')[0]}'),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }

  // Funktion zum Verbinden mit einem ausgewählten Gerät
  void _connectToDevice(fbp.BluetoothDevice device) async {
    fbp.FlutterBluePlus.stopScan();
    try {
      await device.connect();
      print('Verbunden mit: ${device.platformName}');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verbunden mit ${device.platformName}!'),
          backgroundColor: Colors.green[600],
        ),
      );
      // Nach erfolgreicher Verbindung zum HomeScreen navigieren und das Gerät übergeben
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(device: device)),
      );
    } catch (e) {
      print("Fehler beim Verbinden mit ${device.platformName}: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verbindung fehlgeschlagen: ${e.toString().split(':')[0]}'),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth-Geräte suchen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.lightGreen[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Anzeige des Bluetooth-Adapter-Status
            if (_adapterState != fbp.BluetoothAdapterState.on)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Bluetooth ist derzeit ${_adapterState.name.toUpperCase()}. Bitte schalten Sie es ein.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              _isScanning ? 'Suche nach Geräten...' : 'Gefundene Geräte:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[900],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isScanning
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.lightGreen,
                    ),
                  )
                : _foundDevices.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(Icons.bluetooth_disabled, size: 80, color: Colors.lightGreen[300]),
                            const SizedBox(height: 10),
                            Text(
                              'Keine Geräte gefunden. Stellen Sie sicher, dass Ihr Futterautomat eingeschaltet ist und Bluetooth aktiviert ist.',
                              style: TextStyle(fontSize: 18, color: Colors.green[600]),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _foundDevices.length,
                          itemBuilder: (context, index) {
                            final device = _foundDevices[index];
                            return Card(
                              elevation: 6,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.lightGreen.shade200, width: 2.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.devices_other, color: Colors.lightGreen[700]),
                                title: Text(
                                  device.platformName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightGreen[800],
                                  ),
                                ),
                                subtitle: Text('ID: ${device.remoteId}', style: TextStyle(color: Colors.green[600])),
                                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.green[400]),
                                onTap: () => _connectToDevice(device),
                              ),
                            );
                          },
                        ),
                      ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isScanning || _adapterState != fbp.BluetoothAdapterState.on ? null : _startScan,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: (_isScanning || _adapterState != fbp.BluetoothAdapterState.on) ? Colors.lightGreen[300] : Colors.lightGreen[700],
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Text(
                _isScanning ? 'Suche läuft...' : 'Erneut suchen',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Second Screen for displaying squirrel data and handling internal notifications
class HomeScreen extends StatefulWidget {
  final fbp.BluetoothDevice? device; // Make device nullable

  const HomeScreen({super.key, this.device});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Liste zum Speichern der empfangenen Benachrichtigungen (für die interne Anzeige)
  final List<Map<String, String>> _notifications = [];
  StreamSubscription<List<int>>? _characteristicSubscription;
  fbp.BluetoothCharacteristic? _targetCharacteristic;

  // UUIDs von deinem ESP32-Code
  final Guid serviceUuid = Guid("12345678-1234-1234-1234-1234567890ab");
  final Guid characteristicUuid = Guid("abcd1234-5678-90ab-cdef-1234567890ab");


  @override
  void initState() {
    super.initState();
    // Die _notifications-Liste startet jetzt leer und wird durch eingehende Bluetooth-Nachrichten gefüllt.

    if (widget.device != null) {
      _discoverServicesAndListen(widget.device!);
    } else {
      // Handle the case where no device is connected, perhaps show a message or go back
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kein Bluetooth-Gerät verbunden. Bitte verbinden Sie zuerst ein Gerät.'),
            backgroundColor: Colors.orange[600],
          ),
        );
        // Optional: Zurück zum Scan-Screen navigieren, wenn kein Gerät verbunden ist
        // Navigator.of(context).pop();
      });
    }
  }

  @override
  void dispose() {
    _characteristicSubscription?.cancel();
    super.dispose();
  }

  Future<void> _discoverServicesAndListen(fbp.BluetoothDevice device) async {
    try {
      List<fbp.BluetoothService> services = await device.discoverServices();
      for (fbp.BluetoothService service in services) {
        if (service.uuid == serviceUuid) {
          for (fbp.BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.uuid == characteristicUuid) {
              if (characteristic.properties.notify || characteristic.properties.indicate) {
                _targetCharacteristic = characteristic;
                await _targetCharacteristic!.setNotifyValue(true);
                _characteristicSubscription = _targetCharacteristic!.onValueReceived.listen((value) {
                  if (value.isNotEmpty) {
                    final receivedString = String.fromCharCodes(value);
                    _handleIncomingString(receivedString);
                  }
                });
                print('Listening to characteristic: ${characteristic.uuid}');
                return; // Nur diese eine Characteristic abonnieren
              }
            }
          }
        }
      }
      print('Keine Characteristic mit notify/indicate Eigenschaft für Benachrichtigungen gefunden.');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Keine Benachrichtigungs-Characteristic mit den angegebenen UUIDs gefunden.'),
          backgroundColor: Colors.orange[600],
        ),
      );
    } catch (e) {
      print("Fehler beim Entdecken der Services oder Einrichten der Benachrichtigungen: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler bei der Dienstsuche oder Benachrichtigungseinrichtung: ${e.toString().split(':')[0]}'),
          backgroundColor: Colors.red[600],
        ),
      );
    }
  }

  void _handleIncomingString(String receivedString) {
    debugPrint('Received Bluetooth string: $receivedString');
    final now = DateTime.now();
    final timeFormatted = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} Uhr";

    // Fügt den empfangenen String zur Liste der Benachrichtigungen für die Anzeige in der UI hinzu
    setState(() {
      // Füge die neue Benachrichtigung am Anfang der Liste ein
      _notifications.insert(0, {
        'time': 'Heute, $timeFormatted',
        'message': receivedString,
      });
    });
  }

  // Helper method to build a data card with expressive design
  Widget _buildDataCard({required String title, required String value, required IconData icon, required String description}) {
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: Colors.lightGreen.shade400, width: 2.0),
      ),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[100],
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 35, color: Colors.lightGreen[800]),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen[900],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[700],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green[600],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a notification card
  Widget _buildNotificationCard({required String time, required String message}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.green.shade200, width: 1.5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.notifications_active, color: Colors.amber[800], size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SquirrelWatch Daten', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.lightGreen[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Data Cards Section
            Text(
              'Aktuelle Daten',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[900],
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 18.0,
              childAspectRatio: 0.9,
              children: <Widget>[
                _buildDataCard(
                  title: 'Letzter Besuch',
                  value: 'Heute, 10:30 Uhr',
                  icon: Icons.access_time,
                  description: 'Ein neugieriges Eichhörnchen wurde gesichtet!',
                ),
                _buildDataCard(
                  title: 'Anzahl Fütterungen',
                  value: '142',
                  icon: Icons.restaurant,
                  description: 'Gesamtzahl der Fütterungsereignisse.',
                ),
                _buildDataCard(
                  title: 'Durchschnittliche Besuchsdauer',
                  value: '3 min 15 s',
                  icon: Icons.timer,
                  description: 'Durchschnittliche Verweildauer pro Besuch.',
                ),
                _buildDataCard(
                  title: 'Futterstand',
                  value: '75%',
                  icon: Icons.food_bank,
                  description: 'Geschätzter Futterbestand im Automaten.',
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Notification History Section
            Text(
              'Letzte Benachrichtigungen',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[900],
              ),
            ),
            const SizedBox(height: 15),
            // Dynamisch hinzugefügte Benachrichtigungen anzeigen
            if (_notifications.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Noch keine Benachrichtigungen erhalten.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return _buildNotificationCard(
                    time: notification['time']!,
                    message: notification['message']!,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
