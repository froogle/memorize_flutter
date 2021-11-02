import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];

final gameProvider = StateNotifierProvider<MemorizeGame, List<PlayingCard>>(
    (ref) => MemorizeGame());

class MemorizeGame extends StateNotifier<List<PlayingCard>> {
  MemorizeGame() : super([]) {
    startNewGame(10);
  }

  void startNewGame(int pairs) {
    var counter = pairs > emojis.length ? emojis.length : pairs;
    var shuffledEmojis = emojis;
    shuffledEmojis.shuffle();

    List<PlayingCard> deckOfCards = [];
    for (var i = 0; i < counter; i++) {
      deckOfCards
          .add(PlayingCard(id: _uuid.v4(), faceValue: shuffledEmojis[i]));
      deckOfCards
          .add(PlayingCard(id: _uuid.v4(), faceValue: shuffledEmojis[i]));
    }

    deckOfCards.shuffle();
    state = deckOfCards;
  }

  void flipCard(PlayingCard cardToFlip) {
    state = [
      for (final card in state)
        if (card.id == cardToFlip.id)
          PlayingCard(
              id: card.id, faceValue: card.faceValue, faceUp: !card.faceUp)
        else
          card,
    ];
  }
}

class PlayingCard {
  PlayingCard({required this.id, required this.faceValue, this.faceUp = false});
  final String id;
  final String faceValue;
  final bool faceUp;
}
