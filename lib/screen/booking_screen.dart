import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kossan/model/booking_model.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/screen/detail_booking_screen.dart';
import 'package:provider/provider.dart';
import 'package:kossan/provider/theme_provider.dart';

class BookingScreen extends StatefulWidget {
  final Product kamar;

  const BookingScreen({required this.kamar});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late DateTime checkInDate;
  late DateTime checkOutDate;

  @override
  void initState() {
    super.initState();
    checkInDate = DateTime.now();
    checkOutDate = DateTime.now().add(Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice =
        widget.kamar.price * checkOutDate.difference(checkInDate).inDays;

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for ${widget.kamar.title}'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'img/${widget.kamar.imagePath}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.kamar.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Price per month: Rp ${widget.kamar.price}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      _buildDateField(
                          label: 'Check-in', selectedDate: checkInDate),
                      const SizedBox(height: 8),
                      _buildDateField(
                          label: 'Check-out', selectedDate: checkOutDate),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () async {
                    final booking = Booking(
                      roomTitle: widget.kamar.title,
                      price: widget.kamar.price,
                      checkInDate: checkInDate,
                      checkOutDate: checkOutDate,
                      status: 'Confirmed',
                    );

                    // Save the booking data to Firestore

                    try {
                      // Saving to Firestore
                      await FirebaseFirestore.instance
                          .collection('bookings')
                          .add(booking.toMap());
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Booking Confirmed')));

                      // Navigate to booking details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBookingScreen(
                            kamar: widget.kamar,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            booking: booking,
                          ),
                        ),
                      );
                    } catch (e) {
                      {
                        // Catch any errors during the Firestore operation
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    }

                    // Navigate to booking details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBookingScreen(
                          kamar: widget.kamar,
                          checkInDate: checkInDate,
                          checkOutDate: checkOutDate,
                          booking: booking,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(
      {required String label, required DateTime selectedDate}) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            if (label == 'Check-in') {
              checkInDate = picked;
            } else {
              checkOutDate = picked;
            }
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$label: ${selectedDate.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}
