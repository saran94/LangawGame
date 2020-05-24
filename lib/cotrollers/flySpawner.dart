import 'package:langaw/langaw-game.dart';
import 'package:langaw/components/fly.dart';

class FlySpawner {
  final LangawGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;
  int currentInterval;
  int nextSpawn;

  FlySpawner(this.game) {
    start();
  }

  void start() 
  {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
    game.spawnFly();
  }

  void killAll() 
  {
    while(game.flies.length > 0)
    {
      game.flies.removeLast();
    }
  }

  void update(double t) 
  {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.flies.forEach((Fly fly) {
      if (!fly.isDead) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFly();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}