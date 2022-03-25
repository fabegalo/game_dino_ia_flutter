import 'dart:async';

import 'package:flutter/material.dart';

class Loading {
  BuildContext context;
  bool isBackground;
  dynamic dialogContextCompleter;

  Loading(this.context, {this.isBackground = false});

  void show() async {
    dialogContextCompleter = Completer<BuildContext>();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        if (!dialogContextCompleter.isCompleted) {
          dialogContextCompleter.complete(dialogContext);
        }

        if (isBackground) {
          return SimpleDialog(children: <Widget>[
            Center(
              child: Column(children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please Wait....",
                  style: TextStyle(color: Colors.blueAccent),
                )
              ]),
            )
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void stop() async {
    final dialogContext = await dialogContextCompleter.future;
    Navigator.pop(dialogContext);
  }
}
