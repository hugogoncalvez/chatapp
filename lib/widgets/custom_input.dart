import 'package:flutter/material.dart';

import 'package:chatapp/helpers/size.dart';

class CustomInput extends StatelessWidget {
  String hintText;
  IconData icono;
  TextEditingController textController;
  TextInputType keyboard;
  bool isPassword;

  CustomInput(
      {required this.hintText,
      required this.icono,
      required this.keyboard,
      required this.textController,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (context.isPortrait) ? double.infinity : context.width * 0.5,
      margin: EdgeInsets.only(bottom: context.height * 0.025),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(icono),
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
                horizontal: (context.isPortrait)
                    ? context.height * 0.02
                    : context.width * 0.02,
                vertical: (context.isPortrait)
                    ? context.height * 0.02
                    : context.width * 0.02)),
        autocorrect: false,
        keyboardType: keyboard,
        controller: textController,
        obscureText: isPassword,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.height * 0.05),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
          ]),
    );
  }
}
