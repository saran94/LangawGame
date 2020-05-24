import 'dart:ui';
import 'package:langaw/langaw-game.dart';
import 'package:flame/sprite.dart';

import '../view.dart';
import 'callout.dart';

class Fly {
  final LangawGame game;
  Rect flyRect;
  Rect spriteRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  Sprite spriteToRender;
  Callout callout;

  double flyingSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;

  Fly(this.game)
  {
    callout = Callout(this);
    setTargetLocation();
  }

  void render(Canvas c) {
    spriteToRender.renderRect(c, spriteRect);

    if (game.activeView == View.playing) {
      callout.render(c);
    }
  }

  void update(double t) {
    if(isDead)
    {
      flyRect = flyRect.translate(0, game.tileSize * 10 * t);
      spriteRect = flyRect.inflate(2);

      if(flyRect.top > game.screenSize.height)
      {
        isOffScreen = true;
      }

      spriteToRender = deadSprite;
    }
    else
    {
      //change the flying fly image
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      spriteToRender = flyingSprite[flyingSpriteIndex.toInt()];

      //move the flag fly image 
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) 
      {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } 
      else 
      {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
      spriteRect = flyRect.inflate(2);

      if(game.activeView == View.playing)
      {
        callout.update(t);
      }
    }
  }

  void onTapDown()
  {
    if(isDead != true)
    {
      isDead = true;
      if(game.activeView == View.playing)
      {
        game.score += 1;
      }
    }
  }

  void setTargetLocation() {
    double x = game.rand.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rand.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }
}