import 'dart:html';

import 'scripts/Phrase.dart';

void main() {
  querySelector('#output').text = 'Your Dart app is running.';
  Phrase.nextPhrase().display(querySelector('#output'));
}
