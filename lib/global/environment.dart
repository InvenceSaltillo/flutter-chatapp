import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'https://chat-app-angular-flutter.herokuapp.com/api/'
      : 'http://localhost:3000/api/';

  static String socketUrl = Platform.isAndroid
      ? 'https://chat-app-angular-flutter.herokuapp.com/'
      : 'http://localhost:3000';
}
