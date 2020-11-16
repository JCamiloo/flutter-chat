import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String text;
  final String uid;

  const ChatMessage({this.text, this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.uid == '123'
      ? _message()
      : _partnerMessage()
    );
  }

  Widget _message() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          right: 10,
          bottom: 5,
          left: 50
        ),
        child: Text(this.text, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          color: Color(0xff4D93F6),
          borderRadius: BorderRadius.circular(20)
        ),
      )
    );
  }

  Widget _partnerMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          left: 10,
          bottom: 5,
          right: 50
        ),
        child: Text(this.text, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
      )
    );
  }
}