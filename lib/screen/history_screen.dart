// screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:kossan/provider/booking_provider.dart';
import 'package:kossan/screen/home_screen.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<BookingProvider>(context).bookings;

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
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
      body: bookings.isEmpty
          ? Center(child: Text('No bookings found.'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text('${booking.roomTitle}'),
                  subtitle:
                      Text('${booking.checkInDate} - ${booking.checkOutDate}'),
                  trailing: Text(
                      'Rp ${booking.price * (booking.checkOutDate.difference(booking.checkInDate).inDays)}'),
                );
              },
            ),
    );
  }
}
