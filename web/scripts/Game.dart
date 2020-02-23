import 'dart:async';
import 'dart:html';

import 'Phrase.dart';
import 'SoundController.dart';
import 'TranscribedAudio.dart';
import 'TranscriptionSegment.dart';
import "Weed.dart";
import "package:CommonLib/Random.dart";

class Game {
    Element skyBG;
    Element container;

    //need to tick them down to get rid of them (but only if they are flowers)
    //also for reproduction
    List<Weed> weeds = new List<Weed>();
    //purified weeds only plz
    List<Weed> flowers = new List<Weed>();

    int maxWeeds = 113;
    int maxFlowers = 113;

    double get oddsWeedSpawn{
        if(hp-minHP == 0) return .5;
        return 1/(hp-minHP);
    }
    double get oddsFlowerDie => 1/oddsWeedSpawn;


    //flowers last longer the better the hp
    //and weeds are more likely to spawn compared to inverse hp
    int hp = -113;
    int minHP = -113;
    int maxHP = 113;

    void display(Element parent) {
        skyBG = new DivElement()..classes.add("skyBG");
        container = new DivElement()..classes.add("game");
        parent.append(skyBG);
        skyBG.append(container);
        ButtonElement start = new ButtonElement()..text = "Start"..classes.add("startbutton");
        StreamSubscription listener;
        listener = container.onClick.listen((Event e) {
            SoundController.playSoundEffect("254286__jagadamba__mechanical-switch");
            listener.cancel();
            startGameIntro();
        });

        DivElement titleScreen = new DivElement()..classes.add("titleScreen");
        DivElement div1 = new DivElement()..text = "Garden of the Mind"..classes.add("title");
        ImageElement image = new ImageElement(src: "images/mind.png")..classes.add("logo");
        DivElement div2 = new DivElement()..text = "This game uses both audio and text to provide encouragement and instructions. It uses the keyboard for typing."..classes.add("instructions");
        titleScreen.append(div1);
        titleScreen.append(image);
        titleScreen.append(div2);
        titleScreen.append(start);
        container.append(titleScreen);
    }

    void clearGameScreen() {
        container.text = "";
    }

    void startGameIntro() {
        clearGameScreen();
        SoundController.playMusic("463903__burghrecords__birds-in-spring-scotland");
        TranscribedAudio.introAudio().display(container, tutorialIntroCallback);
    }

    void tutorialIntroCallback() {
        Weed weed = new Absolute();
        spawnWeed(weed);
        //put callback asap because if someont types this out without it the game is unplayable
        weed.callback = tutorial1CallbackPart2;
        StreamSubscription listener;
        listener = weed.sprite.onMouseEnter.listen((Event e) {
            TranscribedAudio.tutorial1Audio().display(container, null);
            listener.cancel();
        });
    }

    void tutorial1CallbackPart2() {
        TranscribedAudio.tutorial2Audio().display(container, null);
        Weed weed = new OClock();
        spawnWeed(weed);
        weed.callback = tutorial2CallbackPart2;
    }

    void tutorial2CallbackPart2() {
        TranscribedAudio.tutorial3Audio().display(container, null);
        Weed weed = new BlackAndWhite();
        spawnWeed(weed);
        weed.callback = tutoria3CallbackPart2;
    }

    void tutoria3CallbackPart2() {
        TranscribedAudio.tutorialFinalAudio().display(container, null);
        tick();
    }

    void spawnWeed([Weed weed, bool flower=false]) {
        int maxY = 400;
        int minY = 280;
        int maxX = 680;
        int minX = 0;
        Random rand = new Random();
        //TODO randomize spawn location
        double number = rand.nextDouble();
        if(weed == null) {
            if (number > .5) {
                weed = new Absolute();
            } else if (number > .3) {
                weed = new OClock();
            } else {
                weed = new BlackAndWhite();
            }
        }
        if(flower) {
            weed.purify();
        }
        weeds.add(weed);
        weed.display(container,rand.nextIntRange(minX, maxX),rand.nextIntRange(minY, maxY));
    }

    /*
       every tick loop, check
     */
    void tick() {
        checkSpawnWeed();
        checkSpawnFlower();
        checkWeedsToFlowers();
        checkFlowersForDeath();
        new Timer(new Duration(milliseconds: 3430), tick);
    }

    void checkFlowersForDeath() {
      final Random rand = new Random();
      final List<Weed> flowersToRemove = new List<Weed>();
      for(final Weed flower in flowers) {
          if(rand.nextDouble() > oddsFlowerDie) {
              flowersToRemove.add(flower);
          }
      }
      flowersToRemove.forEach((Weed w) => flowers.remove(w));
    }

    void checkWeedsToFlowers() {
      final List<Weed> weedsToRemove = new List<Weed>();
      for(final Weed weed in weeds) {
          if(weed.purified) {
              flowers.add(weed);
              weedsToRemove.add(weed);
          }
      }
      weedsToRemove.forEach((Weed w) => weeds.remove(w));
    }

    void checkSpawnWeed() {
        final Random rand = new Random();
        if(hp == 0 && rand.nextBool()) {
            spawnWeed();
        }else if(rand.nextDouble() > oddsWeedSpawn) {
            spawnWeed();
        }
    }

    void checkSpawnFlower() {
        final Random rand = new Random();
        if(hp == 0 && rand.nextBool()) {
            spawnWeed(null, true);
        }else if(rand.nextDouble() > oddsFlowerDie) {
            spawnWeed(null, true);
        }
    }


}