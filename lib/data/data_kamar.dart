import 'dart:collection';
import 'package:kossan/model/kamar.dart';

class DataKamar {
  // Gunakan List tidak dapat diubah
  static final List<Product> _dataKamar = [
    Product(
      id: 1,
      title: 'Kamar 1',
      description: 'Kamar yang nyaman dan modern dengan harga yang terjangkau.',
      price: 600000,
      image: 'assets/images/kamar1.jpg',
      imagePath: 'kamar1.jpg',
    ),
    Product(
      id: 2,
      title: 'Kamar 2',
      description:
          'Kamar yang luas dan mempunyai balkon yang menghadap ke luar.',
      price: 700000,
      image: 'assets/images/kamar2.jpg',
      imagePath: 'kamar2.jpg',
    ),
    Product(
      id: 3,
      title: 'Kamar 3',
      description: 'Kamar yang modern dan mempunyai fasilitas yang lengkap.',
      price: 500000,
      image: 'assets/images/kamar3.jpg',
      imagePath: 'kamar3.jpg',
    ),
    Product(
      id: 4,
      title: 'Kamar 4',
      description: 'Kamar yang luas dan mempunyai fasilitas yang lengkap.',
      price: 1000000,
      image: 'assets/images/kamar4.jpg',
      imagePath: 'kamar4.jpg',
    ),
    Product(
      id: 5,
      title: 'Kamar 5',
      description: 'Kamar yang modern dan mempunyai fasilitas yang lengkap.',
      price: 1200000,
      image: 'assets/images/kamar5.jpg',
      imagePath: 'kamar5.jpg',
    ),
    Product(
      id: 6,
      title: 'Kamar 6',
      description: 'Kamar yang luas dan mempunyai fasilitas yang lengkap.',
      price: 1500000,
      image: 'assets/images/kamar6.jpg',
      imagePath: 'kamar6.jpg',
    ),
    Product(
      id: 7,
      title: 'Kamar 7',
      description: 'Kamar yang modern dan mempunyai fasilitas yang lengkap.',
      price: 900000,
      image: 'assets/images/kamar7.jpg',
      imagePath: 'kamar7.jpg',
    ),
    Product(
      id: 8,
      title: 'Kamar 8',
      description: 'Kamar yang luas dan mempunyai fasilitas yang lengkap.',
      price: 450000,
      image: 'assets/images/kamar8.jpg',
      imagePath: 'kamar8.jpg',
    ),
    Product(
      id: 9,
      title: 'Kamar 9',
      description: 'Kamar yang modern dan mempunyai fasilitas yang lengkap.',
      price: 2000000,
      image: 'assets/images/kamar9.jpg',
      imagePath: 'kamar9.jpg',
    ),
  ];

  // Private Constructor
  DataKamar._();

  // Getter untuk data kamar
  static List<Product> get dataKamar => UnmodifiableListView(_dataKamar);
}
