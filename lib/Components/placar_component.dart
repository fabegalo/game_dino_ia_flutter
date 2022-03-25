import 'package:flame/components.dart';
import 'package:game_dino_ia/components/dino_component.dart';

class PlacarComponent extends TextBoxComponent {
  List<DinoComponent> dinos;

  PlacarComponent(this.dinos);

  // @override
  // Future<void> onLoad() async {
  //   text = 'Placar:\n';

  //   await super.onLoad();
  // }

  @override
  void update(double dt) {
    text = 'Placar:\n';

    // dinos.forEach((element) {
    //   text = text + element.score.toString();
    // });

    for (DinoComponent d in dinos) {
      text += d.score.toString() + '\n';
    }

    super.update(dt);
  }

  // @override
  // void render(Canvas c) {
  //   text = 'Placar:\n';
  //   for (DinoComponent d in dinos) {
  //     text += d.score.toString() + '\n';
  //   }
  //   super.render(c);
  // }

  // @override
  // void drawBackground(Canvas c) {
  //   Rect rect = Rect.fromLTWH(0, 0, width, height);
  //   c.drawRect(rect, Paint()..color = const Color(0xFFFF00FF));
  //   c.drawRect(
  //       rect.deflate(2),
  //       Paint()
  //         ..color = BasicPalette.black.color
  //         ..style = PaintingStyle.stroke);
  // }
}
