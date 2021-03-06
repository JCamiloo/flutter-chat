import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    @required this.text, 
    @required this.uid,
    @required this.animationController
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: this.animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut
        ),
        child: Container(
          child: this.uid == authService.user.uid
          ? _message()
          : _partnerMessage()
        ),
      ),
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