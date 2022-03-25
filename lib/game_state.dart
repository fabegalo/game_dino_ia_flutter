/// Describes the current state of the game.
enum PlayingState {
  /// In the menu.
  paused,

  /// Lost the level.
  lost,

  /// Won the level.
  won,

  /// Playing.
  playing,
}

/// State of the game to track global information.
class GameState {
  /// Current playing state.
  static PlayingState playState = PlayingState.playing;

  ///Seed of the current loaded level
  static late String seed;

  ///Last score if null no new score for current level
  static int? lastScore;

  /// Show or hide debug infromation of flame.
  static bool showDebugInfo = true;

  ///Toggle sounds
  static bool playSounds = true;

  static bool hasCollision = true;

  static int populacao = 5;

  static double velocidade = 5;

  static double gravidade = 2;
}
