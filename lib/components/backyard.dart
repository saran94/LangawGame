import 'dart:ui';
import 'package:langaw/langaw-game.dart';
import 'package:flame/sprite.dart';
import 'package:langaw/view.dart';

class Backyard {
  final LangawGame game;
  Sprite bgSprite;
  Sprite bgSprite2;
  Rect bgRect;
  Rect bgRect2;
  int lastBgUpdatedTime;

  Backyard(this.game) {
    bgSprite = new Sprite('bg/backyard.png');
    bgSprite2 = new Sprite('bg/backyard.png');
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
    bgSprite.renderRect(c, bgRect2);
  }

  void update(double d) {
    if (game.activeView == View.playing) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      if (lastBgUpdatedTime == null) {
        lastBgUpdatedTime = currentTime;
      }
      if (currentTime - lastBgUpdatedTime > 10) {
        bgRect = bgRect.translate(-1, 0);
        bgRect2 = bgRect2.translate(-1, 0);

        if(bgRect.right < 0)
        {
          setBackGroundToInitialPosition();
        }

        lastBgUpdatedTime = currentTime;
      }
    } 
    else 
    {
      setBackGroundToInitialPosition();
    }
  }

  void setBackGroundToInitialPosition() {
    bgRect = Rect.fromLTWH(0, game.screenSize.height - (game.tileSize * 23),
        game.tileSize * 9, game.tileSize * 23);

    bgRect2 = Rect.fromLTWH(
        game.screenSize.width,
        game.screenSize.height - (game.tileSize * 23),
        game.tileSize * 9,
        game.tileSize * 23);
  }
}
