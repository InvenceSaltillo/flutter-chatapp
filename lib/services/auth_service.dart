import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de fomra estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  // Getters del token de fomra estatica
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      '${Environment.apiUrl}login',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      this.autenticando = false;
      return true;
    } else {
      this.autenticando = false;
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      '${Environment.apiUrl}login/new',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      this.usuario = registerResponse.usuario;

      await this._guardarToken(registerResponse.token);

      this.autenticando = false;
      return true;
    } else {
      this.autenticando = false;
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<Map<String, dynamic>> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    try {
      final resp = await http.get(
        '${Environment.apiUrl}login/renew',
        headers: {'x-token': token},
      );

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;

        await this._guardarToken(loginResponse.token);
        return {'ok': true};
      } else {
        this.logOut();
        return {'ok': false};
      }
    } catch (e) {
      print('Error: $e');

      this.logOut();
      return {'ok': false, 'msg': e};
    }
  }

  Future _guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
    return;
  }

  Future logOut() async {
    await _storage.delete(key: 'token');
  }
}
