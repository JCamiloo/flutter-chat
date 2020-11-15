import 'package:flutter/material.dart';
import 'package:chat/models/user.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final users = [
    User(uid: '1', name: 'Juan', email: 'test1@test.com', online: true),
    User(uid: '2', name: 'Camilo', email: 'test2@test.com', online: true),
    User(uid: '3', name: 'David', email: 'test3@test.com', online: true),
    User(uid: '4', name: 'Diana', email: 'test4@test.com', online: false),
    User(uid: '5', name: 'Valentina', email: 'test5@test.com', online: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Name', style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            // child: Icon(Icons.check_circle, color: Colors.blue[400]),
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => ListTile(
          title: Text(users[i].name),
          leading: CircleAvatar(
            child: Text(users[i].name.substring(0,2)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: users[i].online ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        ), 
        separatorBuilder: (_, i) => Divider(), 
        itemCount: users.length
      )
    );
  }
}