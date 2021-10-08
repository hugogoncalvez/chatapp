import 'package:flutter/Material.dart';

import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/loading_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRouts = {
  'usuarios': (_) => UsuariosPage(),
  'register': (_) => RegisterPage(),
  'login': (_) => LoginPage(),
  'loading': (_) => LoadingPage(),
  'chat': (_) => ChatPage()
};
