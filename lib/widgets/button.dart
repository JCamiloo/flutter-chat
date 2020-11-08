import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String text;
  final Function onPressed;

  const Button({
    this.text, 
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            this.text, 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 17
            )
          )
        )
      )
    );
  }
}