import 'dart:developer';

import 'package:estorapp/models/order.dart';
import 'package:estorapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "/OrderScreen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

double latitude = 0.0; // Latitude, in degrees
double longitude = 0.0; // Longitude, in degrees
Future<Order> createOrder(int id, String name, int phone, int quantity,
    String address, double locx, double locy) async {
  final response = await http.post(
    Uri.parse('https://adminsy1234.pythonanywhere.com/api/create_order/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Id products': id.toString(),
      'name': name,
      'phone': phone.toString(),
      'Quantity': quantity.toString(),
      'address': address,
      'locx': locx.toString(),
      'locy': locy.toString(),
    }),
  );
  if (response.statusCode == 201) {
    return Order.fromMap(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();

  Order order = Order(
      id: 0,
      quantity: 1,
      name: '',
      phone: 0,
      locx: 0.0,
      locy: 0.0,
      address: '');

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<LocationData>? checkLocationServices() async {
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        _locationData = await location.getLocation();
        latitude = _locationData.latitude!;
        longitude = _locationData.longitude!;
      } else {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          SystemNavigator.pop();
        } else {
          _locationData = await location.getLocation();
          latitude = _locationData.latitude!;
          longitude = _locationData.longitude!;
        }
      }
    } else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          _locationData = await location.getLocation();
          latitude = _locationData.latitude!;
          longitude = _locationData.longitude!;
        } else {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            SystemNavigator.pop();
          } else {
            _locationData = await location.getLocation();
            latitude = _locationData.latitude!;
            longitude = _locationData.longitude!;
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
    return location.getLocation();
  }

  Product? product;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkLocationServices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسوق',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Anton',
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag)),
          //   IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(Icons.arrow_back),
          //   ),
        ],
      ),
      body: FutureBuilder<LocationData>(
          future: checkLocationServices(),
          builder: (context, data) {
            if (!data.hasData) {
              product = ModalRoute.of(context)!.settings.arguments as Product;
              order.id = product!.id;
              order.locx = latitude;
              order.locy = longitude;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'الاسم',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال الاسم';
                              }
                              order.name = value;
                              return null;
                            },
                            onChanged: (value) => order.name = value,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'الكمية المراد شرائها',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يرجى إدخال رقم  0->9';
                              }
                              order.quantity = int.parse(value);
                              return null;
                            },
                            onChanged: (value) =>
                                order.quantity = int.parse(value),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'موبايل 09',
                            ),
                            validator: (phone) {
                              if (phone!.isEmpty) {
                                return 'Please enter some text';
                              }
                              order.phone = int.parse(phone);
                              return null;
                            },
                            onChanged: (phone) =>
                                order.phone = int.parse(phone),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'العنوان بشكل تقريبي ',
                            ),
                            validator: (address) {
                              if (address!.isEmpty) {
                                return 'Please enter some text';
                              }
                              order.address = address;
                              return null;
                            },
                            onChanged: (address) => order.address = address,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                    width: 180.0,
                    child: FloatingActionButton(
                      child: const Text(
                        'شراء',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      backgroundColor: const Color.fromARGB(255, 244, 244, 190),
                      splashColor: Colors.black,
                      onPressed: () async {
                        log("order" + order.toString());
                        if (_formKey.currentState!.validate()) {
                          try {
                            await createOrder(
                                order.id,
                                order.name,
                                order.phone,
                                order.quantity,
                                order.address,
                                order.locx,
                                order.locy);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("done")));
                            Navigator.pop(context);
                          } on Exception catch (e) {
                            log(e.toString());
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            } else {
              product = ModalRoute.of(context)!.settings.arguments as Product;
              order.id = product!.id;
              order.locx = latitude;
              order.locy = longitude;
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
