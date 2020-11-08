import 'package:flutter/material.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/button.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(title: 'Messenger'),
                _Form(),
                Labels(
                  title: 'Create one!',
                  subtitle: 'Don\'t have an account yet?',
                  route: 'register'
                ),
                Text('Terms & conditions', style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Form extends StatefulWidget {

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),     
      child: Column(
        children: [
          Input(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          Input(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPassword: true,
          ),
          Button(
            text: 'Login',
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            }
          )
        ]
      )
    );
  }
}