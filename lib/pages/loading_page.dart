import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: chekLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future chekLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.idLoggedIn();

    if (autenticado) {
      // TODO: conectar en el Socket server

      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 0),
              pageBuilder: (_, __, ___) => UsuariosPage()));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 0),
              pageBuilder: (_, __, ___) => LoginPage()));
    }
  }
}
