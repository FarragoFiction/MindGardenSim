import 'dart:async';
import 'dart:html';

import 'Phrase.dart';
import 'TranscribedAudio.dart';
import 'TranscriptionSegment.dart';
import "Weed.dart";
import "package:CommonLib/Random.dart";

class Game {
    Element skyBG;
    Element container;
    static AudioElement soundEffects = new AudioElement();
    static AudioElement music = new AudioElement();
    List<Weed> weeds = new List<Weed>();

    //flowers last longer the better the hp
    //and weeds are more likely to spawn compared to inverse hp
    int hp = -1300;
    int minHP = -1300;
    int maxHP = 1300;

    void display(Element parent) {
        skyBG = new DivElement()..classes.add("skyBG");
        container = new DivElement()..classes.add("game");
        parent.append(skyBG);
        skyBG.append(container);
        ButtonElement start = new ButtonElement()..text = "Start"..classes.add("startbutton");
        StreamSubscription listener;
        listener = container.onClick.listen((Event e) {
            playSoundEffect("254286__jagadamba__mechanical-switch");
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
        spawnWeed(new Absolute());
        TranscribedAudio.introAudio().display(container, tutorialIntroCallback);
    }

    void tutorialIntroCallback(TranscribedAudio caller) {
        //TODO wait for them to hover over the flower.
        caller.container.remove();
        playSoundEffect("254286__jagadamba__mechanical-switch");
        startGameNext();
    }

    void spawnWeed([Weed weed]) {
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
        weeds.add(weed);
        weed.display(container,rand.nextIntRange(minX, maxX),rand.nextIntRange(minY, maxY));
    }

    void startGameNext() {
        //TODO start up a weed spawn loop and a flower tick loop
        for(int i = 0; i<13; i++) {
            spawnWeed();
            spawnWeed();
            spawnWeed();
        }
    }

    static void playSoundEffect(String locationWithoutExtension, [loop = false]) {
        if(soundEffects.canPlayType("audio/mpeg").isNotEmpty) soundEffects.src = "Sounds/${locationWithoutExtension}.mp3";
        if(soundEffects.canPlayType("audio/ogg").isNotEmpty) soundEffects.src = "Sounds/${locationWithoutExtension}.ogg";
        soundEffects.loop = loop;
        soundEffects.play();
    }



    static void playMusic(String locationWithoutExtension, [loop = true]) {
        if(music.canPlayType("audio/mpeg").isNotEmpty) music.src = "Sounds/${locationWithoutExtension}.mp3";
        if(music.canPlayType("audio/ogg").isNotEmpty) music.src = "Sounds/${locationWithoutExtension}.ogg";
        music.loop = loop;
        music.play();
    }

}