import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'langaw-game.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';

Future<void> main() async {
  //set full screen
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);

  //load assets
  Flame.images.loadAll(<String>[
  'bg/backyard.png',
  'flies/agile-fly-1.png',
  'flies/agile-fly-2.png',
  'flies/agile-fly-dead.png',
  'flies/drooler-fly-1.png',
  'flies/drooler-fly-2.png',
  'flies/drooler-fly-dead.png',
  'flies/house-fly-1.png',
  'flies/house-fly-2.png',
  'flies/house-fly-dead.png',
  'flies/hungry-fly-1.png',
  'flies/hungry-fly-2.png',
  'flies/hungry-fly-dead.png',
  'flies/macho-fly-1.png',
  'flies/macho-fly-2.png',
  'flies/macho-fly-dead.png',
  'bg/lose-splash.png',
  'branding/title.png',
  'ui/dialog-credits.png',
  'ui/dialog-help.png',
  'ui/icon-credits.png',
  'ui/icon-help.png',
  'ui/start-button.png',
  'ui/callout.png',
  ]);

  //create local storage
  SharedPreferences storage = await SharedPreferences.getInstance();
  
  //set home screen
  LangawGame langawGame = LangawGame(storage);
  runApp(langawGame.widget);

  // Register tap event handler
  TapGestureRecognizer tapGestureRecognizer = new TapGestureRecognizer();
  tapGestureRecognizer.onTapDown = langawGame.onTapDown;
  flameUtil.addGestureRecognizer(tapGestureRecognizer);
}