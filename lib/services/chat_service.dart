import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_reponse.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    try {
      final resp = await http.get('${Environment.apiUrl}mensajes/$usuarioId',
          headers: {
            'Content-type': 'application-json',
            'x-token': await AuthService.getToken()
          });

      final mensajesResponse = mensajesResponseFromJson(resp.body);

      return mensajesResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}
