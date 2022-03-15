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
      'id_products': id,
      'name': name,
      'phone': phone,
      'quantity': quantity,
      'address': address,
      'locx': locx,
      'locy': locy,
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id_products']?.toInt() ?? 0,
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      phone: int.parse(map['phone'] ?? 0),
      address: map['address'] ?? '',
      locx: map['locx'] ?? 0.0,
      locy: map['locy'] ?? 0.0,
    );
  }

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return "name $name\nphone $phone\nquantity $quantity\nid $id\naddress $address\nlocx $locx\nlocy $locy";
  }
}
