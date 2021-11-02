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
      deckOfCards.add(PlayingCard(id: _uuid.v4(), content: shuffledEmojis[i]));
      deckOfCards.add(PlayingCard(id: _uuid.v4(), content: shuffledEmojis[i]));
    }

    deckOfCards.shuffle();
    state = deckOfCards;
  }

  void flipCard(String id) {
    state = [
      for (final card in state)
        if (card.id == id)
          PlayingCard(id: card.id, content: card.content, faceUp: !card.faceUp)
        else
          card,
    ];
  }
}

class PlayingCard {
  PlayingCard({required this.id, required this.content, this.faceUp = false});
  final String id;
  final String content;
  final bool faceUp;
}
