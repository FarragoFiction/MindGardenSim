import 'dart:async';
import 'dart:html';

import 'Key.dart';

class Phrase {
    String text;
    String remainingText;



    Phrase(this.text) {
        this.text = this.text.toUpperCase();
    }

    void display(Element parent) {
        remainingText = text;
        DivElement container = new DivElement()..classes.add("phrase")..text = text;
        parent.append(container);

        StreamSubscription listener;
        listener = window.onKeyDown.listen((KeyboardEvent e) {
            handleTyping(container, listener, e);
        });
    }

    void handleTyping(Element container, StreamSubscription listener,KeyboardEvent e) {
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
    }
}