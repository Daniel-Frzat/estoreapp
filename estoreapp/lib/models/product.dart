import 'dart:convert';

class Product {
  int id;
  int price;
  String title;
  String description;
  String? description2;
  String image;
  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    this.description2,
    required this.image,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'title': title,
      'description': description,
      'description2': description2,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      description2: map['description2'],
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
