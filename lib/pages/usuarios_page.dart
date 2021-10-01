import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/helpers/size.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(email: 'test1@test.com', nombre: 'Maria', onLine: true, uid: '1'),
    Usuario(email: 'test2@test.com', nombre: 'Pedro', onLine: false, uid: '2'),
    Usuario(email: 'test3@test.com', nombre: 'Juan', onLine: true, uid: '3'),
    Usuario(email: 'test4@test.com', nombre: 'Elena', onLine: false, uid: '4')
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Mi nombre',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          color: Colors.black54,
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: context.height * 0.012),
            child: const Icon(
              Icons.check_circle,
              color: Colors.black54,
            ),
          )
        ],
      ),
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
              color: (usuario.onLine) ? Colors.green[300] : Colors.red[400]),
        ));
  }

  void _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
