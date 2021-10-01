import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatapp/widgets/chat_message.dart';
import 'dart:io';

import 'package:chatapp/helpers/size.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _escribiendo = false;
  final List<ChatMessage> _mensages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Column(
            children: [
              CircleAvatar(
                maxRadius: context.height * 0.018,
                child: Text('Te',
                    style: TextStyle(fontSize: context.height * 0.018)),
                backgroundColor: Colors.blue[100],
              ),
              SizedBox(height: context.height * 0.0037),
              Text(
                'Melisa',
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
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800)),
    );

    _mensages.insert(0, nuevoMensage);

    nuevoMensage.animationController.forward();

    setState(() {
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off socket
    for (ChatMessage message in _mensages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
