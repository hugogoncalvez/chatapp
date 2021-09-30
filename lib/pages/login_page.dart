import 'package:chatapp/widgets/custom_botton.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/helpers/size.dart';

class LoginPage extends StatelessWidget {
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
                    ruta: 'register',
                    text1: 'No tienes una cuenta?',
                    text2: 'Crea una ahora!',
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
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.height * 0.05),
      child: Column(
        children: [
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
              texto: 'Ingresar',
              callBack: () {
                print(emailController.text);
              })
        ],
      ),
    );
  }
}
