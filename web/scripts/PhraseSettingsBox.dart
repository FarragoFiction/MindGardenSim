/*
    TODO: list all phrases and their refutation. click a check box to turn them on/off
 */
import 'dart:html';

import 'Weed.dart';
import "Game.dart";
abstract class PhraseSettingsBox {

    static void display(Element parent) {
        //TODO list all phrases plus refutation, by thought type. NOT possible phrases, allPhrases.
        //TODO display checkbox, on click of text or checkbox, remove from list.
        final DivElement container = new DivElement()..classes.add("phraseSettings");
        parent.append(container);
        container.append(new DivElement()..setInnerHtml("It's okay if some of these phrases are too hard to encounter when you're not expecting it. It's okay, too, if you think you don't need to practice fighting these thoughts. <br><br>You can customize your garden however you like.  <br><br>You can even set how quickly the garden changes to make sure its the right level of chill for you.<br><br>If you want to skip the tutorial, that's an <a href = 'index.html?skipTutorial=true'>option</a>, too.")..classes.add("settingsUberInstructions"));
        handleSpeed(container);
        displaySection(container, "OClock Lies/Truths", OClock.allPhrases);
        displaySection(container, "Absolute Lies/Truths", Absolute.allPhrases);
        displaySection(container, "BlackAndWhite Lies/Truths", BlackAndWhite.allPhrases);

    }

    static void handleSpeed(Element parent) {
        DivElement container = new DivElement()..classes.add("inputContainer");
        LabelElement label = new LabelElement()..text = "Seconds Between Updates"..classes.add("label");
        container.append(label);
        NumberInputElement numberInputElement = new NumberInputElement()..classes.add("input");
        container.append(numberInputElement);
        numberInputElement.max = "13";
        numberInputElement.min = "0";
        parent.append(container);
        numberInputElement.value = "${Game.instance.speed}";
        numberInputElement.onChange.listen((Event e) {
            Game.instance.speed = int.parse(numberInputElement.value);
        });

    }

    static void displaySection(Element parent, String label, List<List<dynamic>> phrases) {
        final DivElement container = new DivElement()..classes.add("phraseSettingSection");
        parent.append(container);
        final DivElement titleElement = new DivElement()..text = "$label"..classes.add("settingsSectionLabel");
        final DivElement instructionElement = new DivElement()..text = "Choose Which Phrases To Encounter"..classes.add("settingsInstruction");
        container.append(titleElement);
        container.append(instructionElement);
        for(final List<dynamic> phrase in phrases) {
            final DivElement phraseContainer = new DivElement()..classes.add("phraseContainer");
            container.append(phraseContainer);
            final CheckboxInputElement check = new CheckboxInputElement()..classes.add("phraseCheckbox");
            check.checked = true;
            final DivElement blank = new DivElement();
            final DivElement labelLie = new DivElement()..text = "Lie: ${phrase[0]}"..classes.add("settingsLie");
            final DivElement labelTruth = new DivElement()..text = "Truth: ${phrase[1]}"..classes.add("settingsTruth");

            phraseContainer.onClick.listen((Event e) {
                handleClick(label, phrase, check, phraseContainer);
            });

            phraseContainer.append(check);
            phraseContainer.append(labelLie);
            phraseContainer.append(blank);
            phraseContainer.append(labelTruth);

        }
    }

    static void handleClick(String label, List<dynamic> phrase, CheckboxInputElement checkbox, Element phraseContainer ) {
        if(label.contains("OClock")){
            if(OClock.possiblePhrases.contains(phrase)) {
                OClock.possiblePhrases.remove(phrase);
                checkbox.checked = false;
                phraseContainer.style.opacity = "0.3";
            }else {
                OClock.possiblePhrases.add(phrase);
                checkbox.checked = true;
                phraseContainer.style.opacity = "1.0";
            }
        }else if(label.contains("Absolute")){
            if(Absolute.possiblePhrases.contains(phrase)) {
                Absolute.possiblePhrases.remove(phrase);
                checkbox.checked = false;
                phraseContainer.style.opacity = "0.3";
            }else {
                Absolute.possiblePhrases.add(phrase);
                checkbox.checked = true;
                phraseContainer.style.opacity = "1.0";
            }
        }else if(label.contains("BlackAndWhite")){
            if(BlackAndWhite.possiblePhrases.contains(phrase)) {
                BlackAndWhite.possiblePhrases.remove(phrase);
                checkbox.checked = false;
                phraseContainer.style.opacity = "0.3";
            }else {
                BlackAndWhite.possiblePhrases.add(phrase);
                checkbox.checked = true;
                phraseContainer.style.opacity = "1.0";
            }
        }
    }


}