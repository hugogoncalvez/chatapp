import 'package:chatapp/global/environment.dart';
import 'package:chatapp/models/mensajes_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario usuarioPara = Usuario();

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.tryParse('${Environment.apiURL}/mensajes/$usuarioID');

    final resp = await http.get(uri!, headers: {
      'content-type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajesResponse = mensajesResponseFromJson(resp.body);
    return mensajesResponse.mensajes;
  }
}
