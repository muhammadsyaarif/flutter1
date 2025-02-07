import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SupabaseService supabaseService = SupabaseService();
  Map<String, dynamic>? latestData;

  @override
  void initState() {
    super.initState();
    fetchLatestData();
  }

  Future<void> fetchLatestData() async {
    final response = await supabaseService.fetchData();
    if (response.isNotEmpty) {
      setState(() {
        latestData = response.last;
      });
    }
  }

  void sendTelegramCommand(String command) {
    print("Mengirim perintah: $command");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoring Data'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 50, 150, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.green.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
    
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                latestData == null
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDataCard(
                            icon: Icons.water_drop,
                            color: Colors.blue,
                            title: 'Kelembapan',
                            value: '${latestData?['kelembapan'] ?? 'N/A'}%',
                          ),
                          SizedBox(width: 16),
                          _buildDataCard(
                            icon: Icons.cloud,
                            color: Colors.grey,
                            title: 'Hujan',
                            value: '${latestData?['hujan'] ?? 'N/A'}',
                          ),
                          SizedBox(width: 16),
                          _buildDataCard(
                            icon: Icons.access_time,
                            color: Colors.orange,
                            title: 'Waktu',
                            value: '${latestData?['waktu'] ?? 'N/A'}',
                          ),
                        ],
                      ),
                SizedBox(height: 24),
                _buildTelegramControl(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard({required IconData icon, required Color color, required String title, required String value}) {
    return Expanded(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 80),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 20, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTelegramControl() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Kontrol Telegram',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => sendTelegramCommand('ON'),
              icon: Icon(Icons.power, color: Colors.white),
              label: Text('Nyalakan Perangkat'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => sendTelegramCommand('OFF'),
              icon: Icon(Icons.power_off, color: Colors.white),
              label: Text('Matikan Perangkat'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
