import 'package:flutter/material.dart';

import 'package:chatapp/helpers/size.dart';

class Labels extends StatelessWidget {
  const Labels(
      {Key? key, required this.ruta, required this.text1, required this.text2})
      : super(key: key);

  final String ruta;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(text1,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: (context.isPortrait)
                      ? context.height * 0.018
                      : context.width * 0.018,
                  fontWeight: FontWeight.w300)),
          SizedBox(height: context.height * 0.01),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(text2,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: (context.isPortrait)
                        ? context.height * 0.022
                        : context.width * 0.022,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
