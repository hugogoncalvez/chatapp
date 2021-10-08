import 'package:flutter/material.dart';
import 'package:chatapp/global/environment.dart';
import 'package:chatapp/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  // SocketService(){
  //   _initConfig();
  // }

  void connect() async {
    final token = await AuthService.getToken();
    // Dart client

    _socket = IO.io(
        Environment.socketURL,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .enableForceNew() // enable auto-connection
            .setExtraHeaders({'x-token': token}) // optional
            .build());

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
    print(_serverStatus.toString());
  }
}
