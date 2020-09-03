import 'package:chat/pages/chat/chat_page.dart';
import 'package:chat/pages/loading/loading_page.dart';
import 'package:chat/pages/login/login_page.dart';
import 'package:chat/pages/register/register_page.dart';
import 'package:chat/pages/usuarios/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};

// Map<String, WidgetBuilder> getApplicationRoutes() {
//   return <String, WidgetBuilder>{
//     'usuarios': (_) => UsuariosPage(),
//     'chat': (_) => ChatPage(),
//     'login': (_) => LoginPage(),
//     'register': (_) => RegisterPage(),
//     'loading': (_) => LoadingPage(),
//   };
// }
