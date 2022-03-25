import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class DialogAlert {
  BuildContext context;
  String title;
  String conteudo;

  DialogAlert(this.context, this.title, this.conteudo);

  Widget showDialog() {
    // retorna um objeto do tipo Dialog
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(title),
            // content: Positioned(
            //   left: Consts.padding,
            //   right: Consts.padding,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.green,
            //     radius: Consts.avatarRadius,
            //   ),
            // ),
            content: Text(conteudo),
            actions: <Widget>[
              // define os botões na base do dialogo
              TextButton(
                child: const Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title),
            // content: Positioned(
            //   left: Consts.padding,
            //   right: Consts.padding,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.green,
            //     radius: Consts.avatarRadius,
            //   ),
            // ),
            content: Text(conteudo),
            actions: <Widget>[
              // define os botões na base do dialogo
              CupertinoButton(
                child: const Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  }
}

Future<void> showDialogAlert(context, title, conteudo) async {
  // retorna um objeto do tipo Dialog
  DialogAlert modal = DialogAlert(context, title, conteudo);

  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => modal.showDialog());
}
