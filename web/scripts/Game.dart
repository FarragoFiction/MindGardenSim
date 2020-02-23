import 'dart:async';
import 'dart:html';
import 'dart:math' as Math;
import 'Phrase.dart';
import 'SoundController.dart';
import 'TranscribedAudio.dart';
import 'TranscriptionSegment.dart';
import "Weed.dart";
import "package:CommonLib/Random.dart";

class Game {
    Element stupidExtraDivForSkyShit;
    Element container;
    Element hpMeter;
    static Game _instance;
    static Game get instance => _instance != null?_instance:new Game();

    //need to tick them down to get rid of them (but only if they are flowers)
    //also for reproduction
    List<Weed> weeds = new List<Weed>();
    //purified weeds only plz
    List<Weed> flowers = new List<Weed>();

    int maxWeeds = 113;
    int maxFlowers = 113;

    //thanks to 1669 for helping me remember how linear algebra works
    double get oddsWeedSpawn => -1* hp/226 + 0.5;


    //flowers last longer the better the hp
    //and weeds are more likely to spawn compared to inverse hp
    int hp = -113;
    int minHP = -112;
    int maxHP = 113;

    Game() {
        _instance = this;
    }

    void display(Element parent) {
        stupidExtraDivForSkyShit = new DivElement()..classes.add("gameContainer");
        handleSky();
        container = new DivElement()..classes.add("game");
        parent.append(stupidExtraDivForSkyShit);
        stupidExtraDivForSkyShit.append(container);
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

    void handleSky() {
        DivElement sky1 = new DivElement()..classes.add("skyBG1")..style.background = "url('${randomBG()}')";
        DivElement sky2 = new DivElement()..classes.add("skyBG2")..style.background = "url('${randomBG()}')";;
        DivElement sky3 = new DivElement()..classes.add("skyBG3")..style.background = "url('${randomBG()}')";;
        DivElement sky4 = new DivElement()..classes.add("skyBG4")..style.background = "url('${randomBG()}')";;

        stupidExtraDivForSkyShit.append(sky4);
        stupidExtraDivForSkyShit.append(sky3);
        stupidExtraDivForSkyShit.append(sky2);
        stupidExtraDivForSkyShit.append(sky1);
    }

    String randomBG() {
        Random rand = new Random();
        int bgNum = rand.nextInt(25);
        return "images/CloudStrife/BGclouds$bgNum.png";
    }

    void clearGameScreen() {
        container.text = "";
    }

    void startGameIntro() {
        print("Ghoul made the art for this, and realized that prospit dreamers see their futures in clouds...");
        clearGameScreen();
        hpMeter = new DivElement()..classes.add("hp");
        container.append(hpMeter);
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
        spawnWeed();
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
        checkBG();
        syncHP();
        new Timer(new Duration(milliseconds: 3430*2), tick);
    }

    void checkBG() {
        if(hp > 0 && container.style.background != "url('images/background.png')" ) {
            container.style.background = "url('images/background.png'";
        }else if(hp < 0 && container.style.background != "url('images/BGoverlay.png'") {
            container.style.background = "url('images/BGoverlay.png'";
        }
    }

    void checkFlowersForDeath() {
        print("checking ${flowers.length} flowers for death, odds must be less than ${oddsWeedSpawn}");
      final Random rand = new Random();
      final List<Weed> flowersToRemove = new List<Weed>();
      for(final Weed flower in flowers) {
          if(rand.nextDouble()*2 < oddsWeedSpawn) {
              flowersToRemove.add(flower);
              flower.sprite.remove();
          }else {
              hp = Math.min(maxHP, hp +3);
          }
      }
      flowersToRemove.forEach((Weed w) => flowers.remove(w));
    }

    void checkWeedsToFlowers() {
        print("checking ${weeds.length} for flowerification");
        final List<Weed> weedsToRemove = new List<Weed>();
        for(final Weed weed in weeds) {
              if(weed.purified) {
                  flowers.add(weed);
                  weedsToRemove.add(weed);
              }else {
                hp = Math.max(minHP, hp -1);
              }
        }
        weedsToRemove.forEach((Weed w) => weeds.remove(w));
    }

    void purifiedFlower() {
        hp = Math.min(maxHP, hp +25);
        syncHP();
    }

    void checkSpawnWeed() {
        print("checking weeds for spawn, odds are ${oddsWeedSpawn}");
        final Random rand = new Random();
        //always slight chance of trouble
        if(rand.nextDouble() < oddsWeedSpawn || rand.nextDouble()>0.1) {
            spawnWeed();
        }
    }

    void checkSpawnFlower() {
        print("checking flowers for spawn, odds must be more than are ${oddsWeedSpawn}");
        final Random rand = new Random();
        if(hp > 0 && rand.nextDouble() > oddsWeedSpawn) {
            spawnWeed(null, true);
        }
    }

    void syncHP() {
        hpMeter.text = "HP: $hp";
    }


}