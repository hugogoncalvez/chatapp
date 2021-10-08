import 'package:flutter/material.dart';
import 'package:chatapp/helpers/mostar_alerta.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/widgets/custom_botton.dart';

import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/helpers/size.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: context.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Logo(),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    text1: 'Ya tienes una cuenta?',
                    text2: 'Ingresa ahora!',
                  ),
                  Text('Términos y condiciones de uso',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w200))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.height * 0.05),
      child: Column(
        children: [
          CustomInput(
            hintText: 'Nombre',
            icono: Icons.person_add,
            keyboard: TextInputType.text,
            textController: nameController,
          ),
          CustomInput(
            hintText: 'Correo',
            icono: Icons.email_outlined,
            keyboard: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            hintText: 'Contraseña',
            icono: Icons.lock,
            keyboard: TextInputType.text,
            textController: passController,
            isPassword: true,
          ),
          BotonAzul(
              texto: 'Registrar',
              onPressed: (authService.autenticando)
                  ? () => null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final registerOk = await authService.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passController.text.trim());

                      if (registerOk == true) {
                        // Conectar a nuestro Socket
                        socketService.connect();

                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(
                            context, 'Registro Incorrecto', registerOk);
                      }
                    })
        ],
      ),
    );
  }
}
