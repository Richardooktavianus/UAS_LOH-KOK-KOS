import 'package:flutter/material.dart';
import 'package:kossan/model/pesanan.dart';
import 'package:kossan/model/pesanan_item.dart';
import 'package:kossan/screen/home_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Pesanan> _pesanan = <Pesanan>[];

  @override
  void initState() {
    super.initState();
    _loadPesanan();
  }

  void _loadPesanan() async {
    final pesanan = await Pesanan.getAllPesanan();
    setState(() {
      _pesanan = pesanan ?? <Pesanan>[];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: _pesanan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat pesanan.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _pesanan.length,
              itemBuilder: (context, index) {
                final pesanan = _pesanan[index];
                return ListTile(
                  title: Text('${pesanan.id} - ${pesanan.status}'),
                  subtitle: Text('${pesanan.tanggal} - ${pesanan.total}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPesananScreen(pesanan),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class DetailPesananScreen extends StatelessWidget {
  final Pesanan _pesanan;

  DetailPesananScreen(this._pesanan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID Pesanan: ${_pesanan.id}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${_pesanan.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Tanggal: ${_pesanan.tanggal}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Total: ${_pesanan.total}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Detail Pesanan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _pesanan.items.length,
                itemBuilder: (context, index) {
                  final item = _pesanan.items[index];
                  return ListTile(
                    title: Text('${item.kamarId} x ${item.quantity}'),
                    subtitle: Text('Total: Rp ${item.price * item.quantity}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
