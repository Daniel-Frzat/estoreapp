import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:estorapp/models/product.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = "/ProductScreen";

  const ProductScreen({Key? key}) : super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

Future<List<Product>> fetchData() async {
  http.Response res = await http.get(
    Uri.parse('https://adminsy1234.pythonanywhere.com/api/products/'),
  );
  List<Product> products = [];
  if (res.statusCode == 200) {
    products =
        (json.decode(res.body) as List).map((i) => Product.fromMap(i)).toList();
    return products;
  } else {
    throw Exception('Failed to load ');
  }
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> products;
  @override
  void initState() {
    super.initState();
    products = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          'منتجاتنا',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Anton',
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.home))],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 222, 254, 228),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                FutureBuilder<List<Product>>(
                  future: products,
                  builder: (ctx, snapShot) {
                    if (snapShot.hasData) {
                      return ListView.builder(
                        itemCount: snapShot.data!.length,
                        itemBuilder: (context, index) {
                          Size size = MediaQuery.of(context).size;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            height: 190.0,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/ProductDetailsScreen',
                                    arguments: snapShot.data![index],
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 166.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 15),
                                            blurRadius: 25,
                                            color: Colors.black26,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      left: 0.0,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 10.0,
                                          ),
                                          height: 160.0,
                                          width: 200.0,
                                          child: Image.network(
                                            "https://adminsy1234.pythonanywhere.com/${snapShot.data![index].image}",
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: SizedBox(
                                        height: 136.0,
                                        width: size.width - 200,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              child: Text(
                                                snapShot.data![index].title,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontFamily: 'Anton'),
                                              ), //title
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              child: Text(
                                                snapShot
                                                    .data![index].description2
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontFamily:
                                                        'DancingScript'),
                                              ), //subtitle
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 30.0,
                                                  vertical: 4.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 220, 255, 190),
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                ),
                                                child: Text(
                                                    '${snapShot.data![index].price}'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    } else if (snapShot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapShot.hasError) {
                      return Text(
                          "snapShot error is" + (snapShot.error).toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Anton',
                          ));
                    } else {
                      throw Exception('Failed to load ');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
