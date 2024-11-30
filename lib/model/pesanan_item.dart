class PesananItem {
  int id;
  int pesananId;
  int kamarId;
  int quantity;
  double price;

  PesananItem({
    required this.id,
    required this.pesananId,
    required this.kamarId,
    required this.quantity,
    required this.price,
  });

  factory PesananItem.fromJson(Map<String, dynamic> json) {
    return PesananItem(
      id: json['id'],
      pesananId: json['pesanan_id'],
      kamarId: json['kamar_id'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pesanan_id': pesananId,
      'kamar_id': kamarId,
      'quantity': quantity,
      'price': price,
    };
  }
}
