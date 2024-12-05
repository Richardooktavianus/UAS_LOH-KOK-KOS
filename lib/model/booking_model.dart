class Booking {
  final String roomTitle;
  final double price;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String status;

  Booking({
    required this.roomTitle,
    required this.price,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
  });
}
