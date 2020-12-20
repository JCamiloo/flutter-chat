import 'dart:io';
import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;
  List<ChatMessage> _messages = [];


  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final addressee = chatService.addressee;

    return Scaffold(
      appBar: _chatAppBar(addressee),
      body: _chatContainer(),
    );
  }

  AppBar _chatAppBar(User addressee) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1,
      title: Column(
        children: <Widget>[
          CircleAvatar(
            child: Text(addressee.name.substring(0,2), style: TextStyle(fontSize: 12)),
            backgroundColor: Colors.blue[100],
            maxRadius: 14,
          ),
          SizedBox(height: 3),
          Text(addressee.name, style: TextStyle(color: Colors.black87, fontSize: 12))
        ],
      ),
    );
  }

  Container _chatContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )
          ),
          Divider(height: 1),
          Container(
            color: Colors.white,
            child: _chatControls(),
          )
        ],
      )
    );
  }

  Widget _chatControls() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: _chatInput(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS 
              ? _iosSendButton() 
              : androidSendButton()
            )
          ],
        ),
      )
    );
  }

  TextField _chatInput() {
    return TextField(
      controller: _textController,
      onSubmitted: _handleSubmit,
      onChanged: (String text) {
        setState(() {
          text.trim().length > 0 ? _isWriting = true : _isWriting = false;
        });
      },
      decoration: InputDecoration.collapsed(
        hintText: 'Enviar'
      ),
      focusNode: _focusNode,
    );
  }

  CupertinoButton _iosSendButton() {
    return CupertinoButton(
      child: Text('Send'),
      onPressed: _isWriting ? () => _handleSubmit(_textController.text.trim()) : null
    );
  }

  Container androidSendButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: IconTheme(
        data: IconThemeData(color: Colors.blue[400]),
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(Icons.send),
          onPressed: _isWriting ? () => _handleSubmit(_textController.text.trim()) : null
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.trim().length == 0) return; 

    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '123', 
      text: text,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300))
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messages.forEach((message) => message.animationController.dispose());
  }
}