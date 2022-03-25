import 'dart:ui';
//import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:game_app_flutter/game/PrimeiroGame.dart';
import 'package:game_app_flutter/game/componentes/DinoBox.dart';
import '../PrimeiroGame.dart';

class PlacarScore {
  PrimeiroGame game;
  int count = 0;
  List<DinoBox> dinos;
  double positionText = 740;

  PlacarScore(this.game);

  void render(Canvas c) {
    // double screenCenterX = game.screenSize.width / 2;
    // double screenCenterY = game.screenSize.height / 2;
    // Rect boxRect =
    //     Rect.fromLTWH(screenCenterX - 200, screenCenterY - 360, 150, 100);
    // Paint boxPaint = Paint();
    // boxPaint.color = Colors.lightBlue[200];
    // c.drawRect(boxRect, boxPaint);

    String text = 'Placar :'; // text to render
    ParagraphBuilder paragraph = new ParagraphBuilder(new ParagraphStyle());
    //paragraph.pushStyle(new TextStyle(color: new Color(0xFFFFFFFF), fontSize: 48.0));
    paragraph.addText(text);
    var p = paragraph.build()..layout(new ParagraphConstraints(width: 180.0));
    c.drawParagraph(
        p,
        new Offset(game.screenSize.width - p.width - 200,
            game.screenSize.height - p.height - 740));

    dinos = new List<DinoBox>.from(game.dinos);

    dinos.sort((a, b) => a.score < (b.score) ? 1 : -1);

    for (DinoBox dino in dinos) {
      positionText = positionText - 20;
      if (count < 10) {
        String text = 'Dino $count: ${dino.score}';
        ParagraphBuilder paragraph = new ParagraphBuilder(new ParagraphStyle());
        paragraph.addText(text);
        var p = paragraph.build()
          ..layout(new ParagraphConstraints(width: 180.0));
        c.drawParagraph(
            p,
            new Offset(game.screenSize.width - p.width - 200,
                game.screenSize.height - p.height - (positionText - 20)));
      }
      count++;
    }
    positionText = 760;
    count = 0;
  }

  void update(double t) {}
}
