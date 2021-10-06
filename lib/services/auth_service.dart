import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatapp/models/login_response.dart';

import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/global/environment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  // getters del token de forma estática

  static Future<String> getToken() async {
    const _storage = FlutterSecureStorage();
    var token = await _storage.read(key: 'token');
    if (token!.isNotEmpty) {
      return token;
    } else {
      token = '';
      return token;
    }
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final uri = Uri.tryParse('${Environment.apiURL}/login');

    final resp = await http.post(uri!,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;

   

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      // guardar token en lugar seguro

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final uri = Uri.tryParse('${Environment.apiURL}/login/new');

    final resp = await http.post(uri!,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;

    

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      // guardar token en lugar seguro

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body); // lo mapeo para obtner el mensage
      return respBody['msg'];
    }
  }

  Future<bool> idLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.tryParse('${Environment.apiURL}/login/renew');

    //if (token!.isNotEmpty) {
      final resp = await http.get(uri!,
          headers: {'Content-Type': 'application/json', 'x-token': token.toString()});

     

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;

        // guardar token en lugar seguro

        await _guardarToken(loginResponse.token);

        return true;
      } else {
        logout();
        return false;
      }
    // } else {
    //   return false;
    // }
  }

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
