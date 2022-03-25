import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
    BuildContext context, String titulo, String conteudo) async {
  // configura o button

  Widget btnSim = TextButton(
    child: const Text("Sim"),
    //color: Colors.blue,
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.blue,
    ),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );

  Widget btnNao = TextButton(
    child: const Text("Não"),
    //color: Colors.red,
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.red,
    ),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );

  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text(titulo),
    content: SingleChildScrollView(
      child: Text(conteudo),
    ),
    actions: [btnSim, btnNao],
  );

  // exibe o dialog
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => alerta);
}
