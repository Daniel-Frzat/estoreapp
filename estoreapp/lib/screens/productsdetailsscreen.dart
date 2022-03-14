import 'package:estorapp/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);
  static const routeName = "/ProductDetailsScreen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Product? product;
    product = ModalRoute.of(context)!.settings.arguments as Product;
    @override
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('back'),
        ),
        body: Container(
          color: const Color.fromARGB(255, 220, 255, 190),
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          height: size.width * 0.6,
                          child: Stack(
                            children: [
                              Container(
                                height: size.width * 0.7,
                                width: size.width * 0.7,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://adminsy1234.pythonanywhere.com/${product.image}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                          width: 180.0,
                          child: FloatingActionButton(
                            child: const Text(
                              'شراء',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Anton',
                                  fontSize: 22),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            backgroundColor:
                                const Color.fromARGB(255, 220, 255, 190),
                            splashColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(context, '/OrderScreen',
                                  arguments: product);
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 50.0),
                        )
                      ],
                    ),
                  ),
                  //const Spacer(),
                  Text('\n${product.description}'),
                ],
              ),
            ],
          ),
        ));
  }
}
