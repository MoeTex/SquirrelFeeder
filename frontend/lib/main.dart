import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'dart:typed_data'; // For Uint8List
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp; // Alias für flutter_blue_plus
import 'package:flutter_blue_plus/flutter_blue_plus.dart' show Guid; // Expliziter Import für Guid

void main() {
  runApp(const MyApp());
}

// Unsere globale MaterialColor für das brutalistische Thema
final MaterialColor brutalistGrey = const MaterialColor(
  0xFF212121, // Primärfarbe: Dunkles Grau/Fast Schwarz
  <int, Color>{
    50: Color(0xFFFAFAFA), // Sehr helles Grau/Fast Weiß
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E), // Mittleres Grau
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    900: Color(0xFF212121), // Sehr dunkles Grau/Schwarz
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SquirrelWatch App',
      theme: ThemeData(
        primarySwatch: brutalistGrey, // Brutalistisches Grau als Basis
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Neue Monospace-Schriftart für den Hacker-Look
        fontFamily: 'Fira Code', // Oder 'RobotoMono', 'SourceCodePro', 'SpaceMono'
        // Fallback zu generischer Monospace-Schrift, falls Fira Code nicht verfügbar ist
        // Dies würde eine `pubspec.yaml` Konfiguration von Fira Code erfordern
        // Sie können 'monospace' direkt verwenden, wenn Sie keine benutzerdefinierte Schriftart hinzufügen möchten.
        // fontFamily: 'monospace',

        // Typografie für brutalistisches Schwarz-Weiß mit Monospace-Schrift
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Fira Code'),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: 'Fira Code'),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: 'Fira Code'),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Fira Code'),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: 'Fira Code'),
          bodySmall: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Fira Code'),
          labelLarge: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Fira Code'),
          labelMedium: TextStyle(fontSize: 12, color: Colors.black87, fontFamily: 'Fira Code'),
          labelSmall: TextStyle(fontSize: 11, color: Colors.black54, fontFamily: 'Fira Code'),
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
              fontFamily: 'Fira Code', // Monospace für Bullet Points
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brutalistGrey.shade50, // Sehr helles Grau für den Hintergrund
      body: SafeArea(
        child: SingleChildScrollView( // Macht den Inhalt scrollbar
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // <<<<< WICHTIGE ÄNDERUNG HIER: Bildbox durch ASCII-Art ersetzt >>>>>
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: brutalistGrey.shade900, // Dunkler Hintergrund für die ASCII-Art
                  borderRadius: BorderRadius.circular(0.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  r'''
  /\_/\
 ( o.o )
  > ^ <
  /   \
 (_____)
  " " "
                  ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fira Code',
                    fontSize: 24, // Größe anpassen, damit es gut aussieht
                    color: brutalistGrey.shade50, // Helle Farbe für die ASCII-Art
                    height: 1.0, // Zeilenhöhe anpassen für kompaktere Darstellung
                  ),
                ),
              ),
              const SizedBox(height: 40), // Abstand nach der ASCII-Art

              // Titel des Onboarding-Bildschirms mit ASCII-Emoji
              Text(
                'Willkommen bei SquirrelWatch! <(^_^)>', // Niedliches ASCII-Emoji
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Fira Code', // Monospace für Titel
                ),
              ),
              const SizedBox(height: 20),

              // Beschreibung der App
              Text(
                'Verbinde dich mit deinem smarten Eichhörnchen-Futterautomaten, um Aktivitaeten zu beobachten, Muster zu verfolgen & Daten zu sammeln. _o/', // Winkendes ASCII-Emoji
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontFamily: 'Fira Code', // Monospace für Beschreibung
                ),
              ),
              const SizedBox(height: 30),

              // Anweisungen zur Verbindung (Bullet Points)
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildBulletPoint(Icons.power_settings_new, '1. Stellen Sie sicher, dass Ihr Futterautomat eingeschaltet ist.', Colors.black87),
                    const SizedBox(height: 10),
                    _buildBulletPoint(Icons.bluetooth, '2. Aktivieren Sie Bluetooth auf Ihrem Gerät.', Colors.black87),
                    const SizedBox(height: 10),
                    _buildBulletPoint(Icons.link, '3. Tippen Sie auf "Jetzt starten & Verbinden", um die Kopplung zu beginnen.', Colors.black87),
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
                  foregroundColor: brutalistGrey.shade50, // Weißer Text auf dunklem Button
                  backgroundColor: brutalistGrey.shade900, // Dunkler Button
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Keine Rundung
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Jetzt starten & Verbinden >>', // Hacker-Stil Pfeil
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Fira Code', // Monospace für Button-Text
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

// Der Rest des Codes (BluetoothScanScreen und HomeScreen) bleibt wie gehabt.

// BluetoothScanScreen Class bleibt unverändert
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
          content: Text('Fehler: Bluetooth ist AUS. Bitte einschalten! (x_x)', style: TextStyle(fontFamily: 'Fira Code')),
          backgroundColor: Colors.red[600], // Kritische Fehler bleiben rot
        ),
      );
      return;
    }

    if (_isScanning) {
      fbp.FlutterBluePlus.stopScan();
      await Future.delayed(const Duration(milliseconds: 200)); // Kurze Verzögerung
    }

    _foundDevices.clear();
    try {
      await fbp.FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 1), // Suchdauer auf 1 Sekunde reduziert
      );
    } catch (e) {
      print("Fehler beim Starten des Scans: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('FEHLER: Scan konnte nicht gestartet werden: ${e.toString().split(':')[0]}', style: TextStyle(fontFamily: 'Fira Code')),
          backgroundColor: Colors.red[600], // Kritische Fehler bleiben rot
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
          content: Text('VERBUNDEN: ${device.platformName} (^.^)', style: TextStyle(fontFamily: 'Fira Code')),
          backgroundColor: brutalistGrey.shade700, // Dunkles Grau für Erfolg
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
          content: Text('VERBINDUNG FEHLGESCHLAGEN: ${e.toString().split(':')[0]} (>_<)', style: TextStyle(fontFamily: 'Fira Code')),
          backgroundColor: Colors.red[600], // Kritische Fehler bleiben rot
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth-Geräte suchen', style: TextStyle(color: Colors.white, fontFamily: 'Fira Code')),
        backgroundColor: brutalistGrey.shade900, // Schwarz
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder( // Keine Rundung
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),
          ),
        ),
      ),
      backgroundColor: brutalistGrey.shade50, // Sehr helles Grau
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
                  'WARNUNG: Bluetooth ist derzeit ${_adapterState.name.toUpperCase()}. Bitte schalten Sie es ein. (!o!)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red[700], // Rote Warnung für Bluetooth aus
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Fira Code',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              _isScanning ? 'Suche nach Geräten... |o|' : 'Gefundene Geräte:', // ASCII-Emoji für Suche
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Fira Code',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isScanning
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : _foundDevices.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(Icons.bluetooth_disabled, size: 80, color: brutalistGrey.shade300),
                            const SizedBox(height: 10),
                            Text(
                              'Keine Geräte gefunden. Stellen Sie sicher, dass Ihr Futterautomat eingeschaltet ist und Bluetooth aktiviert ist. (._.)', // Trauriges Emoji
                              style: TextStyle(fontSize: 18, color: Colors.black54, fontFamily: 'Fira Code'),
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
                                borderRadius: BorderRadius.circular(0.0), // Keine Rundung
                                side: BorderSide(color: brutalistGrey.shade300, width: 2.0),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.devices_other, color: brutalistGrey.shade700),
                                title: Text(
                                  device.platformName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: brutalistGrey.shade900,
                                    fontFamily: 'Fira Code',
                                  ),
                                ),
                                subtitle: Text('ID: ${device.remoteId}', style: TextStyle(color: Colors.black54, fontFamily: 'Fira Code')),
                                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: brutalistGrey.shade700),
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
                foregroundColor: brutalistGrey.shade50,
                backgroundColor: (_isScanning || _adapterState != fbp.BluetoothAdapterState.on) ? brutalistGrey.shade300 : brutalistGrey.shade900,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Keine Rundung
                ),
                elevation: 5,
              ),
              child: Text(
                _isScanning ? 'Suche läuft... >:o' : 'Erneut suchen ^_^', // Emojis für Scan-Status
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Fira Code',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HomeScreen Class bleibt unverändert
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
            content: Text('ERROR: Kein Bluetooth-Geraet verbunden. (_;)', style: TextStyle(fontFamily: 'Fira Code')),
            backgroundColor: brutalistGrey.shade700, // Warnfarbe im Theme
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
      print('Keine Characteristic mit notify/indicate Eigenschaft fuer Benachrichtigungen gefunden.');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('FEHLER: Keine Notify-Characteristic gefunden. (T_T)', style: TextStyle(fontFamily: 'Fira Code')),
          backgroundColor: brutalistGrey.shade700, // Warnfarbe im Theme
        ),
      );
    } catch (e) {
      print("Fehler beim Entdecken der Services oder Einrichten der Benachrichtigungen: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERROR: Dienstsuche oder Benachrichtigungseinrichtung fehlgeschlagen: ${e.toString().split(':')[0]}', style: TextStyle(fontFamily: 'Fira Code')),
          backgroundColor: Colors.red[600], // Kritische Fehler bleiben rot
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
        'time': 'HEUTE, $timeFormatted',
        'message': receivedString,
      });
    });
  }

  // Helper method to build a data card with expressive design
  Widget _buildDataCard({required String title, required String value, required IconData icon, required String description}) {
    return Card(
      shape: RoundedRectangleBorder( // Keine Rundung
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(color: brutalistGrey.shade400, width: 2.0),
      ),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: brutalistGrey.shade100,
          borderRadius: BorderRadius.circular(0.0), // Keine Rundung
        ),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 35, color: brutalistGrey.shade900),
                const SizedBox(width: 15),
                Expanded( // Sorgt dafür, dass der Titel nicht überläuft
                  child: Text(
                    title.toUpperCase(), // Titel in Großbuchstaben für Hacker-Look
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Fira Code',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: brutalistGrey.shade900,
                fontFamily: 'Fira Code',
              ),
            ),
            const SizedBox(height: 8),
            Expanded( // Sorgt dafür, dass die Beschreibung nicht überläuft
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: 'Fira Code',
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
        borderRadius: BorderRadius.circular(0.0), // Keine Rundung
        side: BorderSide(color: brutalistGrey.shade200, width: 1.5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.notifications_active, color: Colors.amber[800], size: 30), // Warnfarbe beibehalten
            const SizedBox(width: 15),
            Expanded( // Sorgt dafür, dass die Nachricht nicht überläuft
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Fira Code',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Fira Code',
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
        title: const Text('SQRL_DATA_CENTER', style: TextStyle(color: Colors.white, fontFamily: 'Fira Code')), // Hacker-Stil Titel
        backgroundColor: brutalistGrey.shade900, // Schwarz
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder( // Keine Rundung
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),
          ),
        ),
      ),
      backgroundColor: brutalistGrey.shade50, // Sehr helles Grau
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Data Cards Section
            Text(
              '// AKTUELLE DATEN _O/', // Hacker-Kommentar und Emoji
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Fira Code',
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.95,
              children: <Widget>[
                _buildDataCard(
                  title: 'Letzter Besuch',
                  value: '2025-07-04, 14:30h', // Jahresangabe für Hacker-Look
                  icon: Icons.access_time,
                  description: 'Ein neugieriges Eichhoernchen wurde gesichtet! (^_^)', // Emoji hinzugefügt
                ),
                _buildDataCard(
                  title: 'Anzahl Fuetterungen',
                  value: '142',
                  icon: Icons.restaurant,
                  description: 'Gesamtzahl der Fuetterungsereignisse. (*^*)', // Emoji hinzugefügt
                ),
                _buildDataCard(
                  title: 'Durchschnittliche Besuchsdauer',
                  value: '00:03:15', // Format für Hacker-Look
                  icon: Icons.timer,
                  description: 'Durchschnittliche Verweildauer pro Besuch. (-_~)', // Emoji hinzugefügt
                ),
                _buildDataCard(
                  title: 'Futterstand',
                  value: '75%',
                  icon: Icons.food_bank,
                  description: 'Geschaetzter Futterbestand im Automaten. (o_O)', // Emoji hinzugefügt
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Notification History Section
            Text(
              '// LETZTE LOG-EINTRÄGE', // Hacker-Kommentar
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Fira Code',
              ),
            ),
            const SizedBox(height: 15),
            // Dynamisch hinzugefügte Benachrichtigungen anzeigen
            if (_notifications.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Noch keine Benachrichtigungen erhalten. Sobald Ihr Futterautomat Daten sendet, erscheinen sie hier. (o.O)', // Emoji hinzugefügt
                    style: TextStyle(fontSize: 16, color: Colors.grey[600], fontFamily: 'Fira Code'),
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
