import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('JO', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text('Juan Osorio', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => Text('$i'),
                reverse: true,
              )
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        )
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    text.trim().length > 0 ? _isWriting = true : _isWriting = false;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Send message'
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS 
              ? CupertinoButton(
                child: Text('Send'),
                onPressed: _isWriting ? () => _handleSubmit(_textController.text.trim()) : null
              ) 
              : Container(
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
              )
            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String text) {
    print(text);
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });
  }
}