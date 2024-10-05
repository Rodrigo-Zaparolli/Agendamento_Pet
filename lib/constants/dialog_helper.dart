// lib/helpers/dialog_helpet.dart

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class DialogHelper {
  /// Exibe um diálogo de sucesso com uma mensagem personalizada.
  ///
  Future<void> showSuccessDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // O usuário não pode fechar o diálogo tocando fora dele.
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
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  /// Exibe um diálogo de erro com uma mensagem personalizada.
  Future<void> showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // O usuário não pode fechar o diálogo tocando fora dele.
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
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  /// Exibe um diálogo informativo com uma mensagem personalizada.
  Future<void> showSimpleMessage(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, // O usuário pode fechar o diálogo tocando fora dele.
      builder: (BuildContext context) {
        return AlertDialog(
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
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
