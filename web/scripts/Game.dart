import 'dart:html';

class Game {
    Element container;
    static AudioElement soundEffects = new AudioElement();
    static AudioElement music = new AudioElement();
    static AudioElement voiceOver = new AudioElement();

    void display(Element parent) {
        container = new DivElement()..classes.add("game");
        parent.append(container);
        ButtonElement start = new ButtonElement()..text = "start";
        container.append(start);
        container.onClick.listen((Event e) {
            playSoundEffect("254286__jagadamba__mechanical-switch");
            startGame();
        });
    }

    void startGame() {

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