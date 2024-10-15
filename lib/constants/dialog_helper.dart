import 'package:flutter/material.dart';

class DialogHelper {
  Future<void> showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showSuccessDialog(BuildContext context, String message,
      {VoidCallback? onConfirm}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Usuário não pode fechar o diálogo ao clicar fora
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) {
                  onConfirm();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showSimpleMessage(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Usuário não pode fechar o diálogo ao clicar fora
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text(message)),
              ],
            ),
          ),
        );
      },
    );
  }
}
