import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar(
      {Key? key,
      required String message,
      //si quiero sobreescribir el boton
      String btnLabel = 'OK',
      //duration pox defecto es opcional la puedo RX,
      //si no nos manda va a ser opcional,creo un duration de 2s
      Duration duration = const Duration(seconds: 2),
      //funcion vacia, que puede que la manden puede que no
      //es opcional
      VoidCallback? onOk})
      : super(
          key: key,
          content: Text(message),
          duration: duration,
          action: SnackBarAction(
            label: btnLabel,
            onPressed: () {
              if (onOk != null) {
                onOk();
              }
            },
          ),
        );
}
