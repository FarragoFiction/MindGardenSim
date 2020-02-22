//has a list of transcriptions, and the timecodes they should display at
import 'dart:html';

import 'SoundController.dart';
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

        static TranscribedAudio tutorial1Audio() {
            TranscribedAudio ret = new TranscribedAudio("GARDEN1", <TranscriptionSegment>[]);
           // ret.segments.add(new TranscriptionSegment(0,""));
            ret.segments.add(new TranscriptionSegment(0,"See that nasty thought? If we want to uproot it, we need to counter it with a specific mutation of it. Mutations are rooted in the same fact the negative thought is, but focuses on what you’ve done right, or what you can do right next time rather than wallowing in what you did wrong."));
            ret.segments.add(new TranscriptionSegment(19,"Negative self talk comes in a lot of flavors.  <u>Absolutes</u> are the most basic, they have words like ‘always’, ‘never’, or ‘can’t’ and try to bluster into your garden through confidence.  Then, there are <u>O’Clocks</u>, which  confidently predict the future or claim you are locked into  the present is forever. Finally, we have <u>Black and Whites</u>, dividing the world into two halves and confidently claiming if you aren’t in the first half then OBVIOUSLY you are the absolute worst. "));
            ret.segments.add(new TranscriptionSegment(56,"The thought you looked at is an Absolute. This one claims “I always mess up.”. There’s a few ways to mutate it into something healthier, but my favorite way to handle Absolutes is to chip away at the inflexible, rocky certainty of them.  If you type “I mess up more than I would like, but I’m trying to get better.” you can see how it mutates. Click the weed to type."));
            return ret;
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
                SoundController.playSoundEffect("254286__jagadamba__mechanical-switch");
                button.remove();
                voiceOver.pause(); //this triggers pause listener
            });
            /*TODO
                display this text. meanwhile, keep track of when the NEXT segment will be ready
                when it is, replace the text with the new segment
                if you're done playing, do a callback (might need to wait for an action to remove)
             */
            voiceOver.onPause.listen((Event e) {
                container.remove();
                button.remove();
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