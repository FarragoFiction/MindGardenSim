/*
    TODO: list all phrases and their refutation. click a check box to turn them on/off
 */
import 'dart:html';

import 'Weed.dart';

abstract class PhraseSettingsBox {

    static void display(Element parent) {
        //TODO list all phrases plus refutation, by thought type. NOT possible phrases, allPhrases.
        //TODO display checkbox, on click of text or checkbox, remove from list.
        final DivElement container = new DivElement()..classes.add("phraseSettings");
        parent.append(container);
        container.append(new DivElement()..text = "It's okay if some of these phrases are too hard to encounter when you're not expecting it. It's okay, too, if you think you don't need to practice fighting these thoughts. You can customize your garden however you like."..classes.add("settingsUberInstructions"));
        displaySection(container, "OClock Lies/Truths", OClock.allPhrases);
        displaySection(container, "Absolute Lies/Truths", Absolute.allPhrases);
        displaySection(container, "BlackAndWhite Lies/Truths", BlackAndWhite.allPhrases);

    }

    static void displaySection(Element parent, String label, List<List<String>> phrases) {
        final DivElement container = new DivElement()..classes.add("phraseSettingSection");
        parent.append(container);
        print("going to display section $label, with phrases $phrases");
        final DivElement titleElement = new DivElement()..text = "$label"..classes.add("settingsSectionLabel");
        final DivElement instructionElement = new DivElement()..text = "Choose Which Phrases To Encounter"..classes.add("settingsInstruction");
        container.append(titleElement);
        container.append(instructionElement);
        for(final List<String> phrase in phrases) {
            print("phrase is $phrase");
            DivElement phraseContainer = new DivElement()..classes.add("phraseContainer");
            container.append(phraseContainer);
            final CheckboxInputElement check = new CheckboxInputElement()..classes.add("phraseCheckbox");
            final DivElement blank = new DivElement();
            final DivElement labelLie = new DivElement()..text = "Lie: ${phrase[0]}"..classes.add("settingsLie");
            final DivElement labelTruth = new DivElement()..text = "Truth: ${phrase[1]}"..classes.add("settingsTruth");;

            phraseContainer.append(check);
            phraseContainer.append(labelLie);
            phraseContainer.append(blank);
            phraseContainer.append(labelTruth);

        }
    }

}