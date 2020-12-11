import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/button.dart';
import 'package:chat/widgets/spinner.dart';
import 'package:chat/helpers/alert.dart';

class RegisterScreen extends StatelessWidget {

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
                  title: '¡Ingresa!',
                  subtitle: '¿Ya tienes una cuenta?',
                  route: 'login'
                )
              ]
            )
          )
        )
      )
    );
  }
}

class _Form extends StatefulWidget {

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),     
      child: Column(
        children: [
          Input(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          Input(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          Input(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPassword: true,
          ),
          authService.isRegistering ? 
          Spinner() :
          Button(
            text: 'Ingresar',
            onPressed: () async {
             FocusScope.of(context).unfocus();
              final response = await authService.register(
                nameCtrl.text.trim(), 
                emailCtrl.text.trim(), 
                passCtrl.text.trim()
              );
              
              if (response.success) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                showAlert(context, 'Ups!', response.message);
              }
            }
          )
        ]
      )
    );
  }
}