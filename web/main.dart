import 'dart:html';

import 'scripts/Game.dart';
import 'scripts/Phrase.dart';
import 'scripts/PhraseSettingsBox.dart';
import 'scripts/Weed.dart';

void main() async {
  Game game = new Game();
  window.addEventListener("keydown", plzStopSpace );
  game.display(querySelector('#output'));
  await Weed.slurpPhrases();
  PhraseSettingsBox.display(querySelector('#output'));
  //Phrase.nextPhrase().display(querySelector('#output'));
}

void plzStopSpace(Event e) {
  if(e.target == querySelector("body")) {
    e.preventDefault();
  }
}
