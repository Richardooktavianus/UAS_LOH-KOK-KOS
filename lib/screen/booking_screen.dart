// screens/booking_screen.dart
import 'package:flutter/material.dart';
import 'package:kossan/model/booking_model.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/screen/detail_booking_screen.dart';
import 'package:provider/provider.dart';
import 'package:kossan/provider/booking_provider.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'img/${widget.kamar.imagePath}',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text('Price per month: Rp ${widget.kamar.price}'),
            SizedBox(height: 16),
            TextFormField(
              initialValue: checkInDate.toLocal().toString().split(' ')[0],
              decoration: InputDecoration(
                labelText: 'Check-in',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: checkInDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null && picked != checkInDate) {
                  setState(() {
                    checkInDate = picked;
                  });
                }
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: checkOutDate.toLocal().toString().split(' ')[0],
              decoration: InputDecoration(
                labelText: 'Check-out',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: checkOutDate,
                  firstDate: checkInDate,
                  lastDate: DateTime(2030),
                );
                if (picked != null && picked != checkOutDate) {
                  setState(() {
                    checkOutDate = picked;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final booking = Booking(
                  roomTitle: widget.kamar.title,
                  price: widget.kamar.price,
                  checkInDate: checkInDate,
                  checkOutDate: checkOutDate,
                  status: 'Confirmed',
                );
                Provider.of<BookingProvider>(context, listen: false)
                    .addBooking(booking);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBookingScreen(
                      kamar: widget.kamar,
                      checkInDate: checkInDate,
                      checkOutDate: checkOutDate,
                    ),
                  ),
                );
              },
              child: Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
