import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

// Import the Bluetooth Low Energy (BLE) package with an alias
// You need to add 'flutter_blue_plus: ^1.27.0' (or the latest version) to your pubspec.yaml
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp; // Alias ohne 'show' hinzugefügt

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
      body: SafeArea( // Stellt sicher, dass der Inhalt nicht von System-UI-Elementen verdeckt wird
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Zentriert den Inhalt vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Zentriert den Inhalt horizontal
            children: <Widget>[
              // Ein Bild, das die App repräsentiert, mit spielerischem Rahmen
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen[200], // Hintergrundfarbe für den spielerischen Rahmen
                  borderRadius: BorderRadius.circular(25.0), // Stark abgerundete Ecken
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreen.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5), // Schatten für Tiefe
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10), // Innenabstand für den Rahmen
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0), // Abgerundete Ecken für das Bild
                  child: Image.network(
                    'https://placehold.co/600x400/9CCC65/ffffff?text=Squirrel+Feeder+App', // Angepasstes Platzhalterbild in Grün
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
                      color: Colors.lightGreen[100], // Angepasste Fehlerbild-Farbe
                      child: const Icon(Icons.image_not_supported, size: 100, color: Colors.lightGreen),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Vertikaler Abstand

              // Titel des Onboarding-Bildschirms
              Text(
                'Willkommen bei SquirrelWatch!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34, // Etwas größer
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen[900],
                ),
              ),
              const SizedBox(height: 20), // Vertikaler Abstand

              // Beschreibung der App
              Text(
                'Verbinden Sie sich mit Ihrem smarten Eichhörnchen-Futterautomaten, um Eichhörnchen-Aktivitäten zu beobachten, Fütterungsmuster zu verfolgen und wertvolle Daten zu sammeln.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[700], // Passende grüne Textfarbe
                ),
              ),
              const SizedBox(height: 30), // Vertikaler Abstand

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
              const SizedBox(height: 40), // Vertikaler Abstand

              // Call-to-Action-Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the BluetoothScanScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BluetoothScanScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightGreen[700], // Kräftigerer Grünton
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18), // Größerer Button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35), // Stärker abgerundeter Button
                  ),
                  elevation: 8, // Stärkerer Schatten
                ),
                child: const Text(
                  'Jetzt starten & Verbinden',
                  style: TextStyle(
                    fontSize: 22, // Größerer Text
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
    _adapterStateSubscription = fbp.FlutterBluePlus.adapterState.listen((state) { // Alias verwendet
      setState(() {
        _adapterState = state;
      });
      // Wenn der Adapter an ist, starte den Scan automatisch
      if (state == fbp.BluetoothAdapterState.on && !_isScanning) { // Alias verwendet
        _startScan();
      }
    });

    // Überwachen der Scan-Ergebnisse
    _scanResultsSubscription = fbp.FlutterBluePlus.scanResults.listen((results) { // Alias verwendet
      for (fbp.ScanResult result in results) { // Alias verwendet
        // Füge nur Geräte hinzu, die einen Namen haben und noch nicht in der Liste sind
        if (result.device.platformName.isNotEmpty && !_foundDevices.any((d) => d.remoteId == result.device.remoteId)) {
          setState(() {
            _foundDevices.add(result.device);
          });
        }
      }
    });

    // Überwachen des Scan-Status (ob ein Scan läuft)
    fbp.FlutterBluePlus.isScanning.listen((scanning) { // Alias verwendet
      setState(() {
        _isScanning = scanning;
      });
    });

    // Starte den Scan initial
    // Verwenden Sie addPostFrameCallback, um sicherzustellen, dass der Kontext bereit ist
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScan();
    });
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _scanResultsSubscription?.cancel();
    fbp.FlutterBluePlus.stopScan(); // Alias verwendet
    super.dispose();
  }

  // Funktion zum Starten des Bluetooth-Scans
  void _startScan() async {
    // Stellen Sie sicher, dass der Kontext gültig ist, bevor Sie ScaffoldMessenger verwenden
    if (!mounted) return;

    if (_adapterState != fbp.BluetoothAdapterState.on) { // Alias verwendet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bitte schalten Sie Bluetooth ein, um Geräte zu finden.'),
          backgroundColor: Colors.orange[600],
        ),
      );
      return;
    }

    if (_isScanning) {
      fbp.FlutterBluePlus.stopScan(); // Alias verwendet
      await Future.delayed(const Duration(milliseconds: 500)); // Kurze Pause, um den vorherigen Scan zu beenden
    }

    _foundDevices.clear(); // Liste vor neuem Scan leeren
    try {
      // Startet den Scan mit längerer Dauer und aggressivem Modus
      await fbp.FlutterBluePlus.startScan( // Alias verwendet
        timeout: const Duration(seconds: 30), // Längere Scan-Dauer
        // androidScanMode: fbp.ScanMode.lowLatency, // Diese Zeile wurde entfernt, um den Fehler zu beheben
      );
    } catch (e) {
      print("Fehler beim Starten des Scans: $e");
      // Stellen Sie sicher, dass der Kontext gültig ist, bevor Sie ScaffoldMessenger verwenden
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
  void _connectToDevice(fbp.BluetoothDevice device) async { // Alias verwendet
    fbp.FlutterBluePlus.stopScan(); // Alias verwendet
    try {
      // Verbindung zum Gerät aufbauen
      await device.connect();
      print('Verbunden mit: ${device.platformName}');
      // Stellen Sie sicher, dass der Kontext gültig ist, bevor Sie ScaffoldMessenger verwenden
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verbunden mit ${device.platformName}!'),
          backgroundColor: Colors.green[600],
        ),
      );
      // Nach erfolgreicher Verbindung zum HomeScreen navigieren
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      print("Fehler beim Verbinden mit ${device.platformName}: $e");
      // Stellen Sie sicher, dass der Kontext gültig ist, bevor Sie ScaffoldMessenger verwenden
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
        backgroundColor: Colors.lightGreen[700], // Grüne AppBar
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.lightGreen[50], // Grüner Hintergrund
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Anzeige des Bluetooth-Adapter-Status
            if (_adapterState != fbp.BluetoothAdapterState.on) // Alias verwendet
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
                color: Colors.lightGreen[900], // Dunkelgrüner Text
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isScanning
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.lightGreen, // Grüner Ladeindikator
                    ),
                  )
                : _foundDevices.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(Icons.bluetooth_disabled, size: 80, color: Colors.lightGreen[300]), // Angepasstes Icon
                            const SizedBox(height: 10),
                            Text(
                              'Keine Geräte gefunden. Stellen Sie sicher, dass Ihr Futterautomat eingeschaltet ist und Bluetooth aktiviert ist.',
                              style: TextStyle(fontSize: 18, color: Colors.green[600]), // Grüner Text
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
                              elevation: 6, // Etwas mehr Schatten für spielerischen Effekt
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Stärker abgerundete Ecken
                                side: BorderSide(color: Colors.lightGreen.shade200, width: 2.0), // Kontrastreicherer Rand
                              ),
                              child: ListTile(
                                leading: Icon(Icons.devices_other, color: Colors.lightGreen[700]), // Grünes Icon
                                title: Text(
                                  device.platformName, // Verwende den echten Gerätenamen
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightGreen[800], // Grüner Text
                                  ),
                                ),
                                subtitle: Text('ID: ${device.remoteId}', style: TextStyle(color: Colors.green[600])), // Grüner Untertitel
                                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.green[400]),
                                onTap: () => _connectToDevice(device),
                              ),
                            );
                          },
                        ),
                      ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isScanning || _adapterState != fbp.BluetoothAdapterState.on ? null : _startScan, // Button deaktivieren, wenn gescannt wird oder BT aus ist // Alias verwendet
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: (_isScanning || _adapterState != fbp.BluetoothAdapterState.on) ? Colors.lightGreen[300] : Colors.lightGreen[700], // Angepasste Button-Farben // Alias verwendet
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

// Second Screen for displaying squirrel data
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Helper method to build a data card with expressive design
  Widget _buildDataCard({required String title, required String value, required IconData icon, required String description}) {
    return Card(
      // Changed shape for expressive design
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(25.0), // Stärker abgeschrägte Ecken
        side: BorderSide(color: Colors.lightGreen.shade400, width: 2.0), // Prägnanterer Rand
      ),
      elevation: 8, // Stärkerer Schatten für mehr Tiefe
      child: Container( // Using Container for background color and padding inside the shape
        decoration: BoxDecoration(
          color: Colors.lightGreen[100], // Leichter Grünton als Hintergrund
          borderRadius: BorderRadius.circular(20.0), // Passend zu Card's BeveledRectangleBorder
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 35, color: Colors.lightGreen[800]), // Größere, kräftigere Icons
                const SizedBox(width: 15),
                Expanded( // Use Expanded for the title to prevent overflow in smaller cards
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 22, // Angepasste Schriftgröße
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen[900], // Dunkelgrün
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
                fontSize: 36, // Prägnanterer Wert
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[700], // Kräftigeres Grün
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 15, // Angepasste Schriftgröße
                  color: Colors.green[600], // Grüner Text
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
      elevation: 4, // Etwas mehr Schatten
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0), // Stärker abgerundete Ecken
        side: BorderSide(color: Colors.green.shade200, width: 1.5), // Subtiler grüner Rand
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0), // Etwas mehr Padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.notifications_active, color: Colors.amber[800], size: 30), // Kräftigeres Bernstein
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
                      fontSize: 17, // Etwas größerer Text
                      color: Colors.green[800], // Dunkelgrün
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
        backgroundColor: Colors.lightGreen[700], // Grüne AppBar
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.lightGreen[50], // Grüner Hintergrund
      body: SingleChildScrollView( // Enables scrolling for many cards
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to start for titles
          children: <Widget>[
            // Data Cards Section
            Text(
              'Aktuelle Daten',
              style: TextStyle(
                fontSize: 26, // Größerer Titel
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[900], // Dunkelgrüner Text
              ),
            ),
            const SizedBox(height: 15),
            // Grid for data cards
            GridView.count(
              shrinkWrap: true, // Important to make GridView work inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
              crossAxisCount: 2, // 2 columns
              crossAxisSpacing: 18.0, // Etwas mehr Abstand
              mainAxisSpacing: 18.0, // Etwas mehr Abstand
              childAspectRatio: 0.9, // Angepasstes Verhältnis für die Kartenhöhe
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
            const SizedBox(height: 40), // Spacer before notifications

            // Notification History Section
            Text(
              'Letzte Benachrichtigungen',
              style: TextStyle(
                fontSize: 26, // Größerer Titel
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen[900], // Dunkelgrüner Text
              ),
            ),
            const SizedBox(height: 15),
            _buildNotificationCard(
              time: 'Heute, 10:30 Uhr',
              message: 'Eichhörnchen wurde am Futterautomaten gesichtet!',
            ),
            _buildNotificationCard(
              time: 'Gestern, 16:45 Uhr',
              message: 'Futterstand ist niedrig (25%).',
            ),
            _buildNotificationCard(
              time: '2 Tage her, 08:00 Uhr',
              message: 'Neues Eichhörnchen registriert!',
            ),
            _buildNotificationCard(
              time: 'Letzte Woche, 12:10 Uhr',
              message: 'Bewegung erkannt – Eichhörnchen war kurz da.',
            ),
            // Add more notification cards here as needed
          ],
        ),
      ),
    );
  }
}

