import 'dart:html';

import 'scripts/Phrase.dart';

void main() {
  querySelector('#output').text = 'Your Dart app is running.';
  Phrase phrase = new Phrase("THE QUICK BROWN FOX RACED PAST THE LAZY DOG.");
  phrase.display(querySelector('#output'));
}
