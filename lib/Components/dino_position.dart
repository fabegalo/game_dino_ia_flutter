import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_dino_ia/components/dino_component.dart';
import 'package:game_dino_ia/dino_game.dart';

/// Draw the stats of our rocket.
class DinoPosition extends PositionComponent with HasGameRef<DinoGame> {
  /// Create new rocket info instance.
  DinoPosition(this._dino) : super();

  final _textRenderer = TextPaint(
    style: const TextStyle(
      fontSize: 20,
      fontFamily: 'AldotheApache',
      color: Colors.white,
    ),
  );

  var _text = '';

  final DinoComponent _dino;

  @override
  Future<void>? onLoad() {
    _text = 'Pontos: ${_dino.score} \n'
        'Vertical speed: -99.00\n'
        'Horizontal speed: -99.00';
    final textSize = _textRenderer.measureText(_text);
    size = textSize / 3;
    position = Vector2(_dino.position.x, _dino.position.y);
    positionType = PositionType.viewport;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position = Vector2(_dino.position.x, _dino.position.y);
    // _text = '''
    //     Pontos ${_dino.score}
    //     Velocidade: ${gameRef.velocity}
    //     Vertical speed: 123}
    //     ''';
    _text = _dino.isBot == true ? 'BOT' : 'YOU';
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final pos = Vector2.zero();
    _text.split('\n').forEach((line) {
      _textRenderer.render(canvas, line, pos);
      pos.y += size.y / 3;
    });

    super.render(canvas);
  }
}
