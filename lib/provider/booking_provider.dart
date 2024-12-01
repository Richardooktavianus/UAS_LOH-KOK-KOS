// provider/booking_provider.dart
import 'package:flutter/material.dart';
import 'package:kossan/model/booking_model.dart';

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(int index) {
    _bookings.removeAt(index);
    notifyListeners();
  }
}
