import 'dart:ui';
import 'package:langaw/langaw-game.dart';
import 'package:flame/sprite.dart';

class Backyard
{
  final LangawGame game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game)
  {
    bgSprite = new Sprite('bg/backyard.png');
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 9, 
      game.tileSize * 23);
  }

  void render(Canvas c)
  {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double d)
  {

  }
}