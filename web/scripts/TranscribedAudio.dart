//has a list of transcriptions, and the timecodes they should display at
import 'dart:html';

import 'TranscriptionSegment.dart';

class TranscribedAudio {
    AudioElement voiceOver = new AudioElement();
    List<TranscriptionSegment> segments = new List<TranscriptionSegment>();
    bool done = false;
    String audioLocation;
    int index = 0;
    Element container;

        TranscriptionSegment get  nextSegment {
            if(index+1 < segments.length) {
                return segments[index +1];
            }
            return null;
        }

        TranscribedAudio(this.audioLocation, this.segments) {

        }

        static TranscribedAudio introAudio() {
            TranscribedAudio ret = new TranscribedAudio("gardenintro", <TranscriptionSegment>[]);
           // ret.segments.add(new TranscriptionSegment("",0));
            ret.segments.add(new TranscriptionSegment(0,"Hi, JR here, and I’m here to talk to you about the types of self talk and how they directly influence how capable of a person you are.  "));
            ret.segments.add(new TranscriptionSegment(10,"For me, I’ve had my share of failures, mistakes, and moments where my self control and restraint weren’t quite strong enough. But I do my best to tend a garden of my strengths and let any thoughts punishing myself for my weakness be pulled up at the root.  I made this game to try to better explain why I think that’s a source of strength that anyone can pursue. "));
            ret.segments.add(new TranscriptionSegment(35,"On the screen right now, you should see a single weed perservering even in rocky soil. This represents a Mind cultivated in the harsh conditions of negative self talk, where only invasive weeds can grow.  You can see the thoughts associated with the weed if you mouse over it.  Once you’ve confirmed that, I can show you how to begin weeding the garden :)"));
            return ret;
        }

        void display(Element parent, dynamic callback) {
            container = new DivElement()..text = segments[index].text..classes.add("transcription");
            playVoiceOver(audioLocation);
            parent.append(container);
            ButtonElement button = new ButtonElement()..text = "Skip...";
            parent.append(button);
            button.onClick.listen((Event e) {
                button.remove();
                voiceOver.pause();
                callback(this);
            });
            /*TODO
                display this text. meanwhile, keep track of when the NEXT segment will be ready
                when it is, replace the text with the new segment
                if you're done playing, do a callback (might need to wait for an action to remove)
             */
            voiceOver.onPause.listen((Event e) {
                print("i should take this away now");
                callback(this);
            });

            voiceOver.onTimeUpdate.listen((Event e) {
                print(voiceOver.currentTime);
                if(nextSegment != null && voiceOver.currentTime >= nextSegment.timeCodeStart) {
                    container.text = nextSegment.text;
                    index ++;
                }
            });
        }

        void quit() {

        }

        void playVoiceOver(String locationWithoutExtension) {
            if(voiceOver.canPlayType("audio/mpeg").isNotEmpty) voiceOver.src = "Sounds/${locationWithoutExtension}.mp3";
            if(voiceOver.canPlayType("audio/ogg").isNotEmpty) voiceOver.src = "Sounds/${locationWithoutExtension}.ogg";
            voiceOver.play();
        }
}