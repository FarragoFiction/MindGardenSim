import 'dart:async';
import 'dart:html';

import 'Key.dart';
import 'Weed.dart';

class Phrase {
    String text;
    String remainingText;
    static List<Phrase> phrases = new List<Phrase>();
    static int phraseIndex = 0;



    Phrase(this.text) {
        this.text = this.text.toUpperCase();
        phrases.add(this);
    }



    static Phrase nextPhrase() {
        if(phrases.isEmpty) {
            setup();
        }
        phraseIndex ++;
        if(phraseIndex > phrases.length) {
            phraseIndex =1;
            phrases.shuffle();
        }
        return phrases[phraseIndex-1];
    }

    void display(Element parent, dynamic callback) {
        remainingText = text;
        DivElement container = new DivElement()..classes.add("phrase")..text = text;
        parent.append(container);

        StreamSubscription listener;
        listener = window.onKeyDown.listen((KeyboardEvent e) {
            handleTyping(container, listener, e, parent, callback);
        });
    }

    void handleTyping(Element container, StreamSubscription listener,KeyboardEvent e, Element parent, dynamic callback) {
        //TODO if you type the expected next letter, remove it from remaining, change its color
        //TODO if there are no more expected letters, stop listener and remove self
        String expectedKey = remainingText[0];
        Key givenKey = Key.getKeyFromCode(e.keyCode);
        if(givenKey != null && givenKey.keyLetter == expectedKey) {
            remainingText = remainingText.substring(1);
            List<String> split = text.split(remainingText);
            container.setInnerHtml("<font color='green'>${split[0]}</font>${remainingText}");
        }else {
            print ("what is ${e.keyCode} is it $givenKey? ${Key.keys}");
        }

        if(remainingText.isEmpty) {
            listener.cancel();
            container.remove();
            callback();
            //nextPhrase().display(parent);
        }
    }

    static void setup() {
        new Phrase("THE QUICK BROWN FOX RACED PAST THE LAZY DOG.");
        new Phrase("hello world");
    }
}