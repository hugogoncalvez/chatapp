import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/usuarios_service.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/helpers/size.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarioService = UsuriosService();

  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuarioNombre = authService.usuario.nombre;
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: _appBar(usuarioNombre, socketService, context),
      body: SmartRefresher(
        controller: _refreshController,
        child: _listViewUsuarios(),
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue.withOpacity(0.7),
        ),
        onRefresh: _cargarUsuarios,
      ),
    );
  }

  AppBar _appBar(
      String usuarioNombre, SocketService socketService, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        usuarioNombre,
        style: const TextStyle(color: Colors.black54),
      ),
      elevation: 1,
      centerTitle: true,
      leading: IconButton(
        color: Colors.black54,
        onPressed: () {
          // desconectarnos del socket server
          socketService.disconnect();

          Navigator.pushReplacementNamed(context, 'login');
          AuthService.deleteToken();
        },
        icon: const Icon(Icons.exit_to_app),
      ),
      actions: [
        Container(
          // margin: EdgeInsets.only(right: context.height * 0.012),
          child: (socketService.serverStatus == ServerStatus.online)
              ? const Icon(Icons.check_circle, color: Colors.blue)
              : const Icon(Icons.offline_bolt, color: Colors.red),
        )
      ],
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => _usuarioListTile(usuarios[index]),
        separatorBuilder: (_, index) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: context.height * 0.012,
        height: context.height * 0.012,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (usuario.online) ? Colors.green[300] : Colors.red[400]),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _cargarUsuarios() async {
    usuarios = await usuarioService.getUsuarios();
    setState(() {});
    // await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
