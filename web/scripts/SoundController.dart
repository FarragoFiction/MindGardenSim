import 'dart:html';

abstract class SoundController {
    //voice overs are somewehre else btw
    static AudioElement soundEffects = new AudioElement();
    static AudioElement birds = new AudioElement();
    static AudioElement music = new AudioElement();
    static void playSoundEffect(String locationWithoutExtension, [loop = false]) {
        if(soundEffects.canPlayType("audio/mpeg").isNotEmpty) soundEffects.src = "Sounds/${locationWithoutExtension}.mp3";
        if(soundEffects.canPlayType("audio/ogg").isNotEmpty) soundEffects.src = "Sounds/${locationWithoutExtension}.ogg";
        soundEffects.loop = loop;
        soundEffects.play();
    }

    static void playBirds(String locationWithoutExtension, [loop = true]) {
        if(birds.canPlayType("audio/mpeg").isNotEmpty) birds.src = "Sounds/${locationWithoutExtension}.mp3";
        if(birds.canPlayType("audio/ogg").isNotEmpty) birds.src = "Sounds/${locationWithoutExtension}.ogg";
        birds.loop = loop;
        birds.play();
    }

    static nearlyMuteMusic() {
        music.volume = 0.1;
    }

    static unNearlyMuteMusic() {
        music.volume = 0.5;

    }


    static void playMusic(String locationWithoutExtension, [loop = true]) {
        if(music.canPlayType("audio/mpeg").isNotEmpty) music.src = "Sounds/${locationWithoutExtension}.mp3";
        if(music.canPlayType("audio/ogg").isNotEmpty) music.src = "Sounds/${locationWithoutExtension}.ogg";
        music.loop = loop;
        music.play();
    }
}