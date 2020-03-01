import 'dart:async';
import 'dart:html';
import 'dart:math' as Math;
import 'Phrase.dart';
import 'SoundController.dart';
import 'TranscribedAudio.dart';
import 'TranscriptionSegment.dart';
import "Weed.dart";
import "package:CommonLib/Random.dart";
import "package:CommonLib/Logging.dart";

class Game {
    Element stupidExtraDivForSkyShit;
    String playerName = "JR";
    Element bgContainer;
    Element fakeBG = querySelector("#fakebg");
    Element container;
    int bossesDefeated = 0;
    Element hpMeter;
    List<Element> skyShit = new List<Element>();
    Element spookyOverlay;
    bool bossesSpawned = false;
    static Game _instance;
    bool ticking = true;
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
        spookyOverlay = new DivElement()..classes.add("spookyOverLay");
        container = new DivElement()..classes.add("game");
        bgContainer = new DivElement()..classes.add("gamebg");

        checkBG();
        parent.append(stupidExtraDivForSkyShit);
        stupidExtraDivForSkyShit.append(bgContainer);
        stupidExtraDivForSkyShit.append(container);
        stupidExtraDivForSkyShit.append(spookyOverlay);
        ButtonElement start = new ButtonElement()..text = "Ready, Valid Player?"..classes.add("startbutton");
        StreamSubscription listener;
        listener = start.onClick.listen((Event e) {
            SoundController.playSoundEffect("254286__jagadamba__mechanical-switch");
            listener.cancel();
            startGameIntro();
        });

        DivElement titleScreen = new DivElement()..classes.add("titleScreen");
        DivElement div1 = new DivElement()..text = "Garden of the Mind"..classes.add("title");
        ImageElement image = new ImageElement(src: "images/mind.png")..classes.add("logo");
        DivElement div2 = new DivElement()..text = "This game uses both audio and text to provide encouragement and instructions. It uses the keyboard for typing."..classes.add("instructions");
        DivElement div3 = new DivElement()..setInnerHtml("<a target='_blank' href = 'https://www.psychologytoday.com/us/blog/the-athletes-way/201707/silent-third-person-self-talk-facilitates-emotion-regulation'>Research</a> shows that phrasing positive, third person affirmations can help.  Enter your own name, (or a name of a friend you care about), here.", treeSanitizer: NodeTreeSanitizer.trusted)..classes.add("instructions");
        InputElement input = new InputElement()..value = "Valid Player";
        input.onInput.listen((Event e) {
            playerName = input.value;
            start.text = "Ready, $playerName?";
        });
        titleScreen.append(div1);
        titleScreen.append(image);
        titleScreen.append(div2);
        titleScreen.append(div3);
        titleScreen.append(input);

        titleScreen.append(start);
        container.append(titleScreen);
    }

    void handleSky() {
        DivElement sky1 = new DivElement()..classes.add("skyBG1")..style.background = "url('${randomBG()}')";
        DivElement sky2 = new DivElement()..classes.add("skyBG2")..style.background = "url('${randomBG()}')";;
        DivElement sky3 = new DivElement()..classes.add("skyBG3")..style.background = "url('${randomBG()}')";;
        DivElement sky4 = new DivElement()..classes.add("skyBG4")..style.background = "url('${randomBG()}')";;
        skyShit = [sky1,sky2,sky3,sky4];
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
        jrPrint("Ghoul made the art for this, and realized that prospit dreamers see their futures in clouds...");
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

    void jrPrint(String text) {
        String color = "#05ffc9";
        String consortCss = "font-family: 'Nunito', Courier, monospace;color:${color};font-size: 13px;font-weight: bold;";
        fancyPrint("JR: $text", consortCss);
    }

    void bossTime() {
        bossesSpawned = true;
        jrPrint("the bosses are meant to represent how sometimes your brain can fight against progress, give you anxiety or second thoughts about the recovery process, because change is scary and it would rather keep destroying you, because brain lies are jerks.");
        ticking = false;
        hp = -113;
        syncHP();
        Weed boss1 = spawnWeed(new AbsBoss(), false, 50,208, false);
        boss1.callback = defeatBoss;
        Weed boss2 = spawnWeed(new BWBoss(), false, 250,200, false);
        boss2.callback = defeatBoss;
        Weed boss3 = spawnWeed(new ClockBoss(), false, 500,208, false);
        boss3.callback = defeatBoss;
    }

    void defeatBoss() {
        bossesDefeated ++;
        hp = -113;
        if(bossesDefeated == 3) {
            jrPrint("defeating the bosses is basically giving yourself permission to keep recoverying, to stopping the process of punishing yourself for failure, to actively fight to acknowledge the good you're doing so you can keep doing it.");
            ticking = true;
            hp = 1;
            syncHP();
            tick();
        }
    }

    Weed spawnWeed([Weed weed, bool flower=false, int x, int y, bool animation=true]) {
        checkBG();
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
        x ??=rand.nextIntRange(minX, maxX);
        y ??=rand.nextIntRange(minY, maxY);
        weeds.add(weed);
        weed.display(container,x,y,animation);
        return weed;
    }

    /*
       every tick loop, check
     */
    void tick() {
        if(ticking) {
            checkSpawnWeed();
            checkSpawnFlower();
            checkWeedsToFlowers();
            checkFlowersForDeath();
            checkBG();
            syncHP();
            new Timer(new Duration(milliseconds: 3430 * 2), tick);
        }
    }

    void checkBG() {
        bgContainer.style.filter="sepia(${oddsWeedSpawn*100}%)";
        fakeBG.style.filter="sepia(${oddsWeedSpawn*100}%)";
        fakeBG.style.opacity="${1-oddsWeedSpawn}";

        skyShit.forEach((Element e) => e.style.filter = "sepia(${oddsWeedSpawn*50}%)");
        spookyOverlay.style.opacity = "${oddsWeedSpawn/4}";
    }

    void checkFlowersForDeath() {
      final Random rand = new Random();
      final List<Weed> flowersToRemove = new List<Weed>();
      for(final Weed flower in flowers) {
          if(rand.nextDouble()*2 < oddsWeedSpawn) {
              flowersToRemove.add(flower);
              flower.sprite.remove();
          }else {
              hp = Math.min(maxHP, hp +1);
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
        final Random rand = new Random();
        //always slight chance of trouble
        if(rand.nextDouble() < oddsWeedSpawn || rand.nextDouble()>0.1) {
            spawnWeed();
        }
    }

    void checkSpawnFlower() {
        final Random rand = new Random();
        if(hp > 0 && rand.nextDouble() > oddsWeedSpawn) {
            spawnWeed(null, true);
        }
    }

    void syncHP() {
        hpMeter.text = "HP: $hp";
        if(!bossesSpawned && hp >= 0) {
            bossTime();
        }
    }


}