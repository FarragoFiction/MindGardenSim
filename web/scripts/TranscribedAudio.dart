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

        TranscribedAudio(this.audioLocation, this.segments);

        static TranscribedAudio tutorial1Audio() {
            TranscribedAudio ret = new TranscribedAudio("GARDEN1", <TranscriptionSegment>[]);
           // ret.segments.add(new TranscriptionSegment(0,""));
            ret.segments.add(new TranscriptionSegment(0,"See that nasty thought? If we want to uproot it, we need to counter it with a specific mutation of it. Mutations are rooted in the same fact the negative thought is, but focuses on what you’ve done right, or what you can do right next time rather than wallowing in what you did wrong."));
            ret.segments.add(new TranscriptionSegment(19,"Negative self talk comes in a lot of flavors.  <u>Absolutes</u> are the most basic, they have words like ‘always’, ‘never’, or ‘can’t’ and try to bluster into your garden through confidence.  Then, there are <u>O’Clocks</u>, which  confidently predict the future or claim you are locked into  the present is forever. Finally, we have <u>Black and Whites</u>, dividing the world into two halves and confidently claiming if you aren’t in the first half then OBVIOUSLY you are the absolute worst. "));
            ret.segments.add(new TranscriptionSegment(56,"The thought you looked at is an Absolute. This one claims “I always mess up.”. There’s a few ways to mutate it into something healthier, but my favorite way to handle Absolutes is to chip away at the inflexible, rocky certainty of them.  If you type “I mess up more than I would like, but I’m trying to get better.” you can see how it mutates. Click the weed to type."));
            return ret;
        }

    static TranscribedAudio tutorial2Audio() {
        TranscribedAudio ret = new TranscribedAudio("GARDEN2", <TranscriptionSegment>[]);
        // ret.segments.add(new TranscriptionSegment(0,""));
        ret.segments.add(new TranscriptionSegment(0,"You see :) :) :) Isn’t that better? It’s good to remind yourself that you don’t ALWAYS do poorly, and that you can work towards improving your win/lose ratio.  Be more flexible with your self judgements, and future you will be strong."));
        ret.segments.add(new TranscriptionSegment(18,"Speaking of the future, here is an O'Clock thought. This one claims “I’ll never amount to anything.” Never is an *awful* long time for a weed to have knowledge of, isn’t it? Let’s try to mutate it by clicking, then typing “If I get just a little bit stronger each day, eventually I will be completely different from who I am today.”"));
        return ret;
    }

    static TranscribedAudio tutorial3Audio() {
        TranscribedAudio ret = new TranscribedAudio("GARDEN3", <TranscriptionSegment>[]);
        // ret.segments.add(new TranscriptionSegment(0,""));
        ret.segments.add(new TranscriptionSegment(0,"You did it :) :) :)  The future is a huge , unpredictable place and we can steer ourselves towards one we’ll be proud of. Nothing is locked in place, no matter what an O'Clock tries to tell you."));
        ret.segments.add(new TranscriptionSegment(14,"The final thought type is a Black and White.  This one claims “If I’m not perfect, then I’m worthless.”. These ones are especially hard to get rid of for me, mostly because they never really fully surface? They stay underground, encouraging the other thoughts to popup. Go ahead and type “Even if I mess up occasionally, I still have worth.” to get rid of the little jerk."));
        return ret;
    }

    static TranscribedAudio tutorialFinalAudio() {
        TranscribedAudio ret = new TranscribedAudio("GARDENFINAL", <TranscriptionSegment>[]);
        // ret.segments.add(new TranscriptionSegment(0,""));
        ret.segments.add(new TranscriptionSegment(0,"You got it!  It’s hard to get a bead on those mostly hidden thoughts, isn’t it? I try to remember I wouldn’t judge a friend so harshly, as either perfect or subhuman, as black or white, so I should never judge myself that way either."));
        ret.segments.add(new TranscriptionSegment(17,"That’s the basics of the flower types, I really appreciate you listening this far. I have just one more thing to go over with you, and that’s the ambient conditions of the garden."));
        ret.segments.add(new TranscriptionSegment(27,"Right now, with how rocky the soil is, the mutated thoughts don’t last long, do they? They fade quickly, because it’s hard to believe in them when they seem so out of place compared to how harsh reality is.  When you’ve tended a garden of negative self talk for long enough, it can seem pointless or cruel to try to cultivate the mutated positive thoughts. The hardy weeds seem kinder, keeping your guard up in a harsh world protects you. After all, reality won’t forgive you for making a mistake, so why should you coddle yourself? I get it. "));
        ret.segments.add(new TranscriptionSegment(63,"But."));
        ret.segments.add(new TranscriptionSegment(66,"BUT."));
        ret.segments.add(new TranscriptionSegment(68,"THAT is itself a weed. The biggest weed of them all. You can improve the soil, improve YOURSELF and make yourself stronger, more capable, more resilient to stress. You can make your mind a flourishing garden.  To me, that is a much better goal than keeping it a barren wasteland.  I want to be better, to be stronger, to make less mistakes and let each mistake cost me less. When my garden is bare, each mistake takes so much out of me…"));
        ret.segments.add(new TranscriptionSegment(103,"Every second a weed is in place, your garden becomes weaker, less fertile, more rocky. It gets harder for flowers to thrive in it. They vanish nearly as soon as you plant them. But if you start mutating each weed as you find it, something begins to change.  Without the drain of the weeds, the soil is given a chance to recover, and soon each flower can root deeper and deeper into the fertile soil. You might even find flowers start naturally appearing in hospitable conditions."));
        ret.segments.add(new TranscriptionSegment(133,"Negative self talk, the weeds,  are a *punishment* for failing at something important to you. It makes you fear failure, fear *action*. Negative self talk makes you want to give up. Positive self talk, the flowers, are a *reward* for improving. They make you crave success, crave action. They make failure sting just a little bit less, which makes taking action even easier. "));
        ret.segments.add(new TranscriptionSegment(164,"I hope you enjoy working towards making a vibrant garden filled with flowers in this game, and I hope even more that this will inspire you to tend your mental garden, to fill yourself with things that support you and make you strong.  "));
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
            container = new DivElement()..setInnerHtml(segments[index].text)..classes.add("transcription");
            playVoiceOver(audioLocation);
            parent.append(container);
            ButtonElement button = new ButtonElement()..text = "Skip...";
            parent.append(button);
            button.onClick.listen((Event e) {
                SoundController.playSoundEffect("254286__jagadamba__mechanical-switch");
                button.remove();
                voiceOver.pause(); //this triggers pause listener
            });
            voiceOver.onPause.listen((Event e) {
                container.remove();
                button.remove();
                if(callback != null) {
                    callback();
                }
            });

            voiceOver.onTimeUpdate.listen((Event e) {
                if(nextSegment != null && voiceOver.currentTime >= nextSegment.timeCodeStart) {
                    container.setInnerHtml(nextSegment.text);
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