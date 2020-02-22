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
        TranscribedAudio.introAudio().display(container, tutorialIntroCallback);
    }

    void tutorialIntroCallback(TranscribedAudio caller) {
        Weed weed = new Absolute();
        spawnWeed(weed);
        StreamSubscription listener;
        listener = weed.sprite.onMouseEnter.listen((Event e) {
            TranscribedAudio.tutorial1Audio().display(container, tutorial1Callback);
            listener.cancel();
        });
    }

    void tutorial1Callback(TranscribedAudio caller) {
        //TODO give the only weed on screen a callback so i know when its done
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


}