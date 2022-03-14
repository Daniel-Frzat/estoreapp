import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Stack(children: const <Widget>[
          Center(
            child: Image(
              image: AssetImage('assets/images/splashscreen.jpg'),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Center(
            child: Text(
              'Welcome...',
              style: TextStyle(fontFamily: 'DancingScript', fontSize: 80),
            ),
          ),
        ]));
  }
}
