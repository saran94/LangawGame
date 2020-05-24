import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/view.dart';

class MusicButton
{
  final LangawGame game;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled;

  MusicButton(this.game)
  {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');
    isEnabled = true;
  }

  void render(Canvas c)
  {
    if(isEnabled)
    {
      enabledSprite.renderRect(c, rect);
    }
    else
    {
      disabledSprite.renderRect(c,rect);
    }
  }

  void update(double t)
  {

  }

  void onTapDown()
  {
    if(isEnabled)
    {
      isEnabled = false;
      game.homeBGM.pause();
      game.playingBGM.pause();
    }
    else
    {
      isEnabled = true;
      if(game.activeView == View.playing)
      {
        game.playPlayingBGM();
      }
      else
      {
        game.playHomeBGM();
      }
    }
  }
}