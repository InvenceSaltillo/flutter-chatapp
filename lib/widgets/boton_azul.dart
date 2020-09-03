import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String texto;
  final Function onPressed;

  const BotonAzul({@required this.texto, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      elevation: 2,
      hoverElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            texto,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
