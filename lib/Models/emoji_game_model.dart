import 'dart:collection';
import 'package:flutter/material.dart';

class EmojiGameModel extends ChangeNotifier {
  final emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];
  final _deck = <String>[];
  int _pairs = 0;

  UnmodifiableListView<String> get deck => UnmodifiableListView(_deck);

  EmojiGameModel(int numberOfPairs) {
    _pairs = numberOfPairs > emojis.length ? emojis.length : numberOfPairs;

    var shuffledEmojis = emojis;
    shuffledEmojis.shuffle();

    for (var i = 0; i < _pairs; i++) {
      _deck.add(shuffledEmojis[i]);
      _deck.add(shuffledEmojis[i]);
    }

    _deck.shuffle();
  }
}
