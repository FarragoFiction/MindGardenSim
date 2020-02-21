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
    String flowerLocation;
    bool purified = false;
    Element lie;

    Weed(this.brainLie, String refutation, String imageLoc, String this.flowerLocation) {
        phrase = new Phrase(refutation);
        sprite = new ImageElement(src: "images/Flowers/$imageLoc")..classes.add("weed");
    }

    void display(Element container, int x, int y) {
        //TODO make the hover text a tool tip. oh god.

        SpanElement wrapper = new SpanElement()..classes.add("tooltip");
        wrapper.style.position = "absolute";
        wrapper.style.top = "${y}px";
        wrapper.style.left = "${x}px";
        wrapper.style.zIndex = "$y";
        lie = new DivElement()..text = brainLie..classes.add("tooltiptext");
        wrapper.append(sprite);
        wrapper.append(lie);
        container.append(wrapper);
    }

    void purify() {
        lie.text = phrase.text;
        sprite.src = flowerLocation;
        lie.classes.add("purifiedtip"); //be pink and shit
        //TODO cancel sprite.onClick = null;
    }

}

class OClock extends Weed{
  OClock() : super("I’ll never amount to anything.", "If I get just a little bit stronger each day, eventually I will be completely different from who I am today.", "oclock.gif", "clockpure.png");
}

class Absolute extends Weed{
    Absolute() : super("You always mess up.", "I mess up more than I would like, but I’m trying to get better.", "stone.gif","flower1.gif");
}

class BlackAndWhite extends Weed{
    BlackAndWhite() : super("You messed up. You're worthless.", "Even if I mess up occasionally, I still have worth.", "blackandwhite.gif","pinwheelpure.gif");
}