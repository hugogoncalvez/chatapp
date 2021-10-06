import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  elevation: 5,
                  textColor: Colors.blue,
                  child: const Text('Ok'),
                )
              ],
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
                title: Text(titulo),
                content: Text(subtitulo),
                actions: [
                  CupertinoDialogAction(
                      child: const Text('Ok'),
                      isDefaultAction: true,
                      onPressed: () => Navigator.pop(context))
                ]));
  }
}
