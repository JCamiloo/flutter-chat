import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final double width;
  final double height;

  const Spinner({
    this.width = 30, 
    this.height = 30
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: CircularProgressIndicator(),
      ),
    );
  }
}