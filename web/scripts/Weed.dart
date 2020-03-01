import 'dart:html';
import 'dart:async';
import 'Game.dart';
import 'Phrase.dart';

/*
   needs to render self on screen
   if hovered, display brain lie
   if clicked, start phrase
 */
class Weed {
    //TODO load phrase pairs from file
    static String namePlaceholder = "NAME";
    String brainLie;
    Phrase phrase;
    ImageElement sprite;
    String flowerLocation;
    bool purified = false;
    dynamic callback;
    StreamSubscription clickListener;

    Element lie;

    Weed(this.brainLie, String refutation, String imageLoc, String this.flowerLocation) {
        phrase = new Phrase(refutation.replaceAll(namePlaceholder,Game.instance.playerName));
        lie = new DivElement()..text = purified?phrase.text:brainLie..classes.add("tooltiptext");
        sprite = new ImageElement(src: "images/Flowers/$imageLoc")..classes.add("weed");
    }

    void display(Element container, int x, int y) {
        //TODO make the hover text a tool tip. oh god.

        SpanElement wrapper = new SpanElement()..classes.add("tooltip")..classes.add("lietip");
        wrapper.style.position = "absolute";
        wrapper.style.top = "${y}px";
        wrapper.style.left = "${x}px";
        wrapper.style.zIndex = "$y";
        wrapper.append(sprite);
        wrapper.append(lie);
        container.append(wrapper);
        clickListener = wrapper.onClick.listen((Event e) {
            phrase.display(container, purify);
            clickListener.cancel();
        });
    }

    void purify() {
        purified = true;
        lie.style.backgroundColor=null;
        lie.text = phrase.text;
        sprite.src = "images/Flowers/$flowerLocation";
        lie.classes.add("purifiedtip"); //be pink and shit
        lie.classes.remove("lietip");
        if(clickListener!=null)clickListener.cancel();
        if(callback != null) {
            print("callback is $callback, ${callback.runtimeType}");
            callback();
        }
        Game.instance.purifiedFlower();
    }

}
//TODO leave all these things as the default values for them, but also have a constructor for a random thought from a file
class OClock extends Weed{
  OClock() : super("I’ll never amount to anything.", "If you get just a little bit stronger each day, NAME, eventually you will be completely different from who you am today.", "oclock.gif", "clockpure.png");
}

class Absolute extends Weed{
    Absolute() : super("I always mess up.", "You mess up more than you would like, NAME, but you're trying to get better.", "stone.gif","flower1.gif");
}

class BlackAndWhite extends Weed{
    BlackAndWhite() : super("I messed up. I'm worthless.", "Even if you mess up occasionally, you still have worth, NAME.", "blackandwhite.gif","pinwheelpure.gif");
}