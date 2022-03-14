import 'package:flutter/material.dart';

import 'package:estorapp/screens/productsdetailsscreen.dart';
//import 'package:estorapp/screens/splashscreen.dart';
import 'package:estorapp/screens/productsscreen.dart';
import 'package:estorapp/screens/orderscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electrical Store',
      theme: ThemeData(
        primaryColor: Colors.blue,
        secondaryHeaderColor: Colors.blue[900],
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductScreen(),
      routes: {
        ProductScreen.routeName: (_) => const ProductScreen(),
        ProductDetailsScreen.routeName: (_) => const ProductDetailsScreen(),
        OrderScreen.routeName: (_) => const OrderScreen(),
      },
    );
  }
}
