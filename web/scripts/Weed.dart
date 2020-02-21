import 'dart:html';

import 'Phrase.dart';

/*
   needs to render self on screen
   if hovered, display brain lie
   if clicked, start phrase
 */
class Weed {
    //TODO load phrase pairs from file
    String brainLie;
    Phrase phrase;
    ImageElement sprite;

    Weed(this.brainLie, String refutation, String imageLoc) {
        phrase = new Phrase(refutation);
        sprite = new ImageElement(src: "images/Flowers/$imageLoc")..classes.add("weed");
    }

    void display(Element container, int x, int y) {
        //TODO make the hover text a tool tip. oh god.
        sprite.style.top = "${y}px";
        sprite.style.left = "${x}px";
        sprite.style.zIndex = "$y";
        container.append(sprite);
    }
}

class OClock extends Weed{
  OClock() : super("I’ll never amount to anything.", "If I get just a little bit stronger each day, eventually I will be completely different from who I am today.", "oclock.gif");
}

class Absolute extends Weed{
    Absolute() : super("You always mess up.", "I mess up more than I would like, but I’m trying to get better.", "stone.gif");
}

class BlackAndWhite extends Weed{
    BlackAndWhite() : super("You messed up. you're worthless.", "Even if I mess up occasionally, I still have worth.", "blackandwhite.gif");
}