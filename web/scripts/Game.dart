import 'dart:async';
import 'dart:html';

import 'Phrase.dart';

class Game {
    Element container;
    static AudioElement soundEffects = new AudioElement();
    static AudioElement music = new AudioElement();
    static AudioElement voiceOver = new AudioElement();

    //flowers last longer the better the hp
    //and weeds are more likely to spawn compared to inverse hp
    int hp = -1300;
    int minHP = -1300;
    int maxHP = 1300;

    void display(Element parent) {
        container = new DivElement()..classes.add("game");
        parent.append(container);
        ButtonElement start = new ButtonElement()..text = "Start";
        StreamSubscription listener;
        listener = container.onClick.listen((Event e) {
            playSoundEffect("254286__jagadamba__mechanical-switch");
            listener.cancel();
            startGameIntro();
        });

        DivElement titleScreen = new DivElement()..text = "Hello World"..classes.add("titleScreen");
        titleScreen.append(start);
        container.append(titleScreen);
    }

    void clearGameScreen() {
        container.text = "";
    }

    void startGameIntro() {
        clearGameScreen();
        playVoiceOver("gardenintro");
        DivElement titleScreen = new DivElement()..text = "TODO: WRITE TRANSCRIPT OF CONTENT HERE"..classes.add("transcript");
        ButtonElement start = new ButtonElement()..text = "Skip...";
        start.onClick.listen((Event e) {
            titleScreen.remove();
            playSoundEffect("254286__jagadamba__mechanical-switch");
            voiceOver.pause();
            startGameNext();
        });
        titleScreen.append(start);
        container.append(titleScreen);
    }

    void startGameNext() {
        Phrase.nextPhrase().display(container);
    }

    static void playSoundEffect(String locationWithoutExtension, [loop = false]) {
        if(soundEffects.canPlayType("audio/mpeg").isNotEmpty) soundEffects.src = "Sounds/${locationWithoutExtension}.mp3";
        if(soundEffects.canPlayType("audio/ogg").isNotEmpty) soundEffects.src = "Sounds/${locationWithoutExtension}.ogg";
        soundEffects.loop = loop;
        soundEffects.play();
    }

    static void playVoiceOver(String locationWithoutExtension) {
        if(voiceOver.canPlayType("audio/mpeg").isNotEmpty) voiceOver.src = "Sounds/${locationWithoutExtension}.mp3";
        if(voiceOver.canPlayType("audio/ogg").isNotEmpty) voiceOver.src = "Sounds/${locationWithoutExtension}.ogg";
        voiceOver.play();
    }

    static void playMusic(String locationWithoutExtension, [loop = true]) {
        if(music.canPlayType("audio/mpeg").isNotEmpty) music.src = "Sounds/${locationWithoutExtension}.mp3";
        if(music.canPlayType("audio/ogg").isNotEmpty) music.src = "Sounds/${locationWithoutExtension}.ogg";
        music.loop = loop;
        music.play();
    }
}