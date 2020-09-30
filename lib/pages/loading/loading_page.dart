import 'package:chat/pages/login/login_page.dart';
import 'package:chat/pages/usuarios/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado['ok']) {
      socketService.connect();

      Navigator.pushReplacement(context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => UsuariosPage()));
    } else {
      if (autenticado['msg'] != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('${autenticado['msg']}'),
            actions: <Widget>[
              MaterialButton(
                child: Text('Ok'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginPage()));
                },
              ),
            ],
          ),
        );
      } else {
        Navigator.pushReplacement(context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()));
      }
    }
  }
}
