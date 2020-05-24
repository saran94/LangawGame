import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:langaw/components/highScoreDisplay.dart';
import 'package:langaw/components/scoreDisplay.dart';
import 'package:langaw/cotrollers/flySpawner.dart';
import 'package:langaw/views/creditsView.dart';
import 'package:langaw/views/helpview.dart';
import 'package:langaw/views/lostView.dart';
import 'components/fly.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'components/backyard.dart';
import 'components/housefly.dart';
import 'view.dart';
import 'views/homeViews.dart';
import 'components/startButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangawGame extends Game {
  final SharedPreferences storage;

  Size screenSize;
  double tileSize;
  Random rand;
  Backyard background;
  View activeView;
  HomeView homeView;
  LostView lostView;
  List<Fly> flies;
  StartButton startButton;
  FlySpawner spawner;
  HelpView helpView;
  CreditsView creditsView;
  int score;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  LangawGame(this.storage) {
    initialize();
  }

  void initialize() async {
    //init values
    rand = new Random();
    flies = new List<Fly>();

    //resize
    resize(await Flame.util.initialDimensions());

    //render
    activeView = View.home;
    background = new Backyard(this);
    homeView = new HomeView(this);
    lostView = new LostView(this);
    startButton = new StartButton(this);
    spawner = new FlySpawner(this);
    helpView = new HelpView(this);
    creditsView = new CreditsView(this);
    scoreDisplay = new ScoreDisplay(this);
    highscoreDisplay = new HighscoreDisplay(this);
    score = 0;
  }

  //Implementations
  void render(Canvas canvas) {
    background.render(canvas);

    flies.forEach((fly) => fly.render(canvas));

    if (activeView == View.home) {
      homeView.render(canvas);
      startButton.render(canvas);
    }
    if (activeView == View.lost) {
      lostView.render(canvas);
      startButton.render(canvas);
    }
    if (activeView == View.help) {
      helpView.render(canvas);
    }
    if (activeView == View.credits) {
      creditsView.render(canvas);
    }
    if (activeView == View.playing) {
      scoreDisplay.render(canvas);
      highscoreDisplay.render(canvas);
    }
  }

  void update(double t) {
    
    //spawn flies
    spawner.update(t);

    //update flies
    flies.forEach((fly) {
      fly.update(t);
    });
    flies.removeWhere((fly) => fly.isOffScreen);

    //only for gaming view
    if (activeView == View.playing) {
      //display scores
      scoreDisplay.update(t);

      //display high scores
      if (score > (storage.getInt('highscore') ?? 0)) {
        storage.setInt('highscore', score);
        highscoreDisplay.updateHighscore();
      }
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });

      if (activeView == View.playing && !didHitAFly) {
        activeView = View.lost;
      }
    }
  }

  //Bl methods
  void spawnFly() {
    double x = rand.nextDouble() * (screenSize.width - (tileSize * 2.025));
    double y = rand.nextDouble() * (screenSize.height - (tileSize * 2.025));

    switch (rand.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }
}
