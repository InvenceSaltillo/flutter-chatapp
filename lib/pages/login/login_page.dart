import 'package:flutter/material.dart';

import 'package:chat/pages/login/widgets/form_login.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: 'Messenger',
                ),
                FormLogin(),
                Labels(
                    ruta: 'register',
                    texto1: '¿No tienes cuenta?',
                    texto2: 'Crea una ahora!'),
                Text('Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
