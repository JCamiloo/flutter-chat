import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String title;

  const Logo({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 170,
        child: Column(
          children: [
            Image(image: AssetImage('assets/logo.png')),
            SizedBox(height: 20),
            Text(this.title, style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}