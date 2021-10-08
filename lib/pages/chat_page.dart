import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/chat_service.dart';

import 'package:chatapp/models/mensajes_response.dart';
import 'package:chatapp/widgets/chat_message.dart';
import 'package:chatapp/helpers/size.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  ChatService chatService = ChatService();
  SocketService socketService = SocketService();
  AuthService authService = AuthService();

  bool _escribiendo = false;
  final List<ChatMessage> _mensages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioId) async {
    List<Mensaje> chat = await chatService.getChat(usuarioId);
    final historial = chat.map((m) => ChatMessage(
        texto: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));
    setState(() {
      _mensages.insertAll(0, historial);
    });
  }

  void _escucharMensaje(dynamic payload) {
    //verificamos que el mensaje sea de la conversarion

    if (payload['de'] != chatService.usuarioPara.uid) return;

    ChatMessage nuevoMensage = ChatMessage(
        texto: payload['mensaje'],
        uid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 800)));

    setState(() {
      _mensages.insert(0, nuevoMensage);
    });

    nuevoMensage.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioChat = chatService.usuarioPara;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Column(
            children: [
              CircleAvatar(
                maxRadius: context.height * 0.018,
                child: Text(usuarioChat.nombre.substring(0, 2),
                    style: TextStyle(fontSize: context.height * 0.018)),
                backgroundColor: Colors.blue[100],
              ),
              SizedBox(height: context.height * 0.0037),
              Text(
                usuarioChat.nombre,
                style: TextStyle(
                    color: Colors.black54, fontSize: context.height * 0.018),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) => _mensages[index],
                itemCount: _mensages.length,
              ),
            ),
            const Divider(height: 1, thickness: 1),
            Container(
              color: Colors.white,
              child: _inputChat(context),
            )
          ],
        ));
  }

  Widget _inputChat(BuildContext context) {
    return SafeArea(
        bottom: true,
        left: false,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.height * 0.00975),
          child: Row(
            children: [
              Flexible(
                  child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (_textController.text.trim().isNotEmpty) {
                      _escribiendo = true;
                    } else {
                      _escribiendo = false;
                    }
                  });
                },
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Enviar mensaje'),
              )),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: context.height * 0.0049),
                child: (Platform.isAndroid)
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.height * 0.0049),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.blue[300]),
                          child: IconButton(
                            splashRadius: 1,
                            icon: const Icon(
                              Icons.send,
                            ),
                            onPressed: (_escribiendo)
                                ? () => _handleSubmit(_textController.text)
                                : null,
                          ),
                        ),
                      )
                    : CupertinoButton(
                        child: const Text('Enviar'),
                        onPressed: (_escribiendo)
                            ? () => _handleSubmit(_textController.text)
                            : null,
                      ),
              )
            ],
          ),
        ));
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;
    _textController.clear();
    _focusNode.requestFocus();

    final nuevoMensage = ChatMessage(
      texto: texto,
      uid: authService.usuario.uid,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800)),
    );

    _mensages.insert(0, nuevoMensage);

    nuevoMensage.animationController.forward();

    setState(() {
      _escribiendo = false;
    });

    socketService.emit('mensaje-personal', {
      'de': authService.usuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _mensages) {
      message.animationController.dispose();
    }

    socketService.socket.off('mensaje-personal');

    super.dispose();
  }
}
