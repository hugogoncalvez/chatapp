import 'package:flutter/material.dart';

import 'package:chatapp/helpers/size.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {required this.texto,
      required this.uid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.elasticInOut),
        child: Container(
          child: (uid == '123') ? _miMensage(context) : _noMiMensage(context),
        ),
      ),
    );
  }

  Widget _miMensage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            bottom: context.height * 0.015,
            left: context.height * 0.05,
            right: context.height * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: context.height * 0.03,
            vertical: context.height * 0.015),
        decoration: BoxDecoration(
            color: const Color(0xff4D9EF6),
            borderRadius: BorderRadius.circular(context.height * 0.5)),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _noMiMensage(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            bottom: context.height * 0.015,
            left: context.height * 0.01,
            right: context.height * 0.05),
        padding: EdgeInsets.symmetric(
            horizontal: context.height * 0.03,
            vertical: context.height * 0.015),
        decoration: BoxDecoration(
            color: const Color(0xffE4E5E8),
            borderRadius: BorderRadius.circular(context.height * 0.5)),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
