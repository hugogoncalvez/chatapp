import 'package:flutter/material.dart';

import 'package:chatapp/helpers/size.dart';

class BotonAzul extends StatelessWidget {
  const BotonAzul({Key? key, required this.texto, required this.callBack})
      : super(key: key);

  final String texto;

  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
        width:
            (context.isPortrait) ? context.height * 0.4 : context.width * 0.5,
        child: TextButton(
          onPressed: callBack,
          child: Text(
            texto,
            style: TextStyle(
                color: Colors.white,
                fontSize: (context.isPortrait)
                    ? context.height * 0.02
                    : context.width * 0.02),
          ),
        ),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(context.height * 0.3),
            color: Colors.blue));
  }
}
