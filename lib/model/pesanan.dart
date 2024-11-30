import 'package:kossan/model/pesanan_item.dart';

class Pesanan {
  int id;
  String status;
  String tanggal;
  int total;
  List<PesananItem> items;

  Pesanan({
    required this.id,
    required this.status,
    required this.tanggal,
    required this.total,
    required this.items,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) => Pesanan(
        id: json['id'],
        status: json['status'],
        tanggal: json['tanggal'],
        total: json['total'],
        items: List<PesananItem>.from(
          json['items'].map((json) => PesananItem.fromJson(json)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'tanggal': tanggal,
        'total': total,
        'items': items.map((e) => e.toJson()).toList(),
      };

  static getAllPesanan() {}
}
