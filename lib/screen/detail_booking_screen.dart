import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kossan/model/booking_model.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/screen/bayar_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:kossan/provider/theme_provider.dart';

class DetailBookingScreen extends StatelessWidget {
  final Product kamar;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  const DetailBookingScreen({
    required this.kamar,
    required this.checkInDate,
    required this.checkOutDate, required Booking booking,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final int totalNights = checkOutDate.difference(checkInDate).inDays;
    final int totalBulan = (totalNights / 30).ceil();
    final double totalPrice = kamar.price * totalBulan;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'img/${kamar.imagePath}',
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kamar.title,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Price per month: Rp ${kamar.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.teal),
                          const SizedBox(width: 10),
                          Text(
                            'Check-in: ${checkInDate.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.teal),
                          const SizedBox(width: 10),
                          Text(
                            'Check-out: ${checkOutDate.toLocal().toString().split(' ')[0]}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total Bulan: $totalBulan',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Price: Rp $totalPrice',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final booking = Booking(
                      roomTitle: kamar.title,
                      price: kamar.price,
                      checkInDate: checkInDate,
                      checkOutDate: checkOutDate,
                      status: 'Confirmed',
                    );

                    // Save the booking data to Firestore
                    await FirebaseFirestore.instance.collection('bookings').add(
                      booking.toMap(),
                    );

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Booking Confirmed')));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BayarSplash(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.teal.shade900,
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
