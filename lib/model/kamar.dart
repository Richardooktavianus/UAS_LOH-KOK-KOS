class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String imagePath;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;

  static Product fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'] as int,
      title: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      image: data['image'] as String,
      imagePath: data['imagePath'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'imagePath': imagePath,
    };
  }
}

