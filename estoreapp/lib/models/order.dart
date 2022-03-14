import 'dart:convert';

class Order {
  int id, phone, quantity;
  String name, address;
  double locx, locy;
  Order(
      {required this.id,
      required this.quantity,
      required this.name,
      required this.phone,
      required this.locx,
      required this.locy,
      required this.address});
  Map<String, dynamic> toMap() {
    return {
      'Id products': id,
      'Name': name,
      'Phone': phone,
      'Quantity': quantity,
      'Address': address,
      'Locx': locx,
      'Locy': locy,
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['Id products']?.toInt() ?? 0,
      name: map['Name']?.toInt() ?? '',
      quantity: map['Quantity'] ?? 0,
      phone: map['Phone'] ?? '',
      address: map['Address'] ?? '',
      locx: map['Locx'] ?? 0.0,
      locy: map['Locy'] ?? 0.0,
    );
  }

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
