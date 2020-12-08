import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/users_screen.dart';
import 'package:chat/widgets/spinner.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Spinner()
          );
        },
      )
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isAuthenticated = await authService.isLoggedIn();

    if (isAuthenticated.success) {
      _navigate(context, UsersScreen());
    } else {
      _navigate(context, LoginScreen());
    }
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionDuration: Duration(milliseconds: 0)
      )
    );
  }
}