import 'dart:html';

import 'Phrase.dart';

/*
   needs to render self on screen
   if hovered, display brain lie
   if clicked, start phrase
 */
class Weed {
    String brainLie;
    Phrase phrase;
    ImageElement sprite;
    Weed(this.brainLie, String refutation, String imageLoc) {
        phrase = new Phrase(refutation);
        sprite = new ImageElement(src: "images/$imageLoc")..classes.add("weed");
    }

    void display(Element container, int x, int y) {
        //TODO make the hover text a tool tip. oh god.
        sprite.style.top = "${y}px";
        sprite.style.left = "${x}px";
        container.append(sprite);
    }
}