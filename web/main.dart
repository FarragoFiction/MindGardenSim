import 'dart:html';

import 'scripts/Game.dart';
import 'scripts/Phrase.dart';

void main() {
  Game game = new Game();
  game.display(querySelector('#output'));
  //Phrase.nextPhrase().display(querySelector('#output'));
}
