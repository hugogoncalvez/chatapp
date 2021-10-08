import 'package:chatapp/global/environment.dart';
import 'package:chatapp/models/usuarios_response.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/models/usuario.dart';

class UsuriosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.tryParse('${Environment.apiURL}/usuarios');

      final resp = await http.get(uri!, headers: {
        'content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
      final usuariosResponce = usuariosResponseFromJson(resp.body);
      return usuariosResponce.usuarios;
    } catch (e) {
      return [];
    }
  }
}
