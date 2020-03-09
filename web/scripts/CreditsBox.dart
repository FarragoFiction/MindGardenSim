/*
    TODO: list all phrases and their refutation. click a check box to turn them on/off
 */
import 'dart:html';

import 'Weed.dart';

abstract class CreditsBox {

    static void display(Element parent) {
        //TODO list all phrases plus refutation, by thought type. NOT possible phrases, allPhrases.
        //TODO display checkbox, on click of text or checkbox, remove from list.
        final DivElement container = new DivElement()..classes.add("credits");
        DivElement header = new DivElement()..text = "Credits"..classes.add("creditsHeader");
        parent.append(header);
        parent.append(container);
        Map<String,String> credits = new Map<String,String>();

        credits["jadedResearcher (JR)"] = "Lead Designer/Programmer/Tutorial Voiceover";
        credits["Ghoul"] = "Art";
        credits["manicInsomniac"] = "Music";
        credits["paradoxLands"] = "Additional Coding";
        credits["yearnfulNode"] = "Tutorial Audio Cleanup";
        credits["PsychologyToday"] = "<a target='_blank' href = 'https://www.psychologytoday.com/us/blog/living-forward/201603/4-ways-stop-beating-yourself-once-and-all'>Positive Self Talk Tips</a> and <a target='_blank'  href = 'https://www.psychologytoday.com/us/blog/the-athletes-way/201707/silent-third-person-self-talk-facilitates-emotion-regulation'>Third Person Tips</a>";
        credits["TherapyAid"] = "<a target='_blank' href = 'https://www.therapistaid.com/therapy-guide/cognitive-restructuring'>Cognitive Restruction Tips</a>";
        credits.keys.forEach((String key) {
            DivElement nameElement = new DivElement()..classes.add("creditsName")..text = key;
            DivElement creditElement = new DivElement()..classes.add("creditsAction")..setInnerHtml(credits[key], treeSanitizer: NodeTreeSanitizer.trusted);
            container.append(nameElement);
            container.append(creditElement);
        });

    }




}