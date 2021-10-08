import 'package:chatapp/services/socket_service.dart';
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
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.idLoggedIn();

    if (autenticado) {
      // conectar en el Socket server

      socketService.connect();

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
