import 'package:flutter/material.dart';

import 'package:chatapp/helpers/size.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:
            (context.isPortrait) ? context.height * 0.2 : context.width * 0.2,
        child: Column(
          children: [
            Image.asset('assets/tag-logo.png'),
            SizedBox(
              height: context.height * 0.015,
            ),
            Text('Messenger',
                style: TextStyle(
                    fontSize: (context.isPortrait)
                        ? context.height * 0.035
                        : context.width * 0.035))
          ],
        ),
      ),
    );
  }
}
