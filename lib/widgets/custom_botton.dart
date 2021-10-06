import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/helpers/size.dart';
import 'package:provider/provider.dart';

class BotonAzul extends StatelessWidget {
  const BotonAzul({Key? key, required this.texto, required this.onPressed})
      : super(key: key);

  final String texto;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
     final authService = Provider.of<AuthService>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: (authService.autenticando) ? Colors.grey : Colors.blue,
          shadowColor: Colors.black,
          shape: const StadiumBorder(),
          minimumSize: Size(
              (context.isPortrait) ? context.height * 0.4 : context.width * 0.5,
              (context.isPortrait)
                  ? context.height * 0.065
                  : context.width * 0.07)),
      onPressed: onPressed,
      child: Text(
        texto,
        style: TextStyle(
            color: Colors.white,
            fontSize: (context.isPortrait)
                ? context.height * 0.02
                : context.width * 0.02),
      ),
    );
  }
}
