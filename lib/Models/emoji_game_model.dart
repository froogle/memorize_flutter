import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];

final gameProvider =
    StateNotifierProvider<EmojiGame, List<EmojiCard>>((ref) => EmojiGame());

class EmojiGame extends StateNotifier<List<EmojiCard>> {
  EmojiGame() : super([]) {
    startNewGame(10);
  }

  void startNewGame(int pairs) {
    var counter = pairs > emojis.length ? emojis.length : pairs;
    var shuffledEmojis = emojis;
    shuffledEmojis.shuffle();

    List<EmojiCard> deck = [];
    for (var i = 0; i < counter; i++) {
      deck.add(EmojiCard(id: _uuid.v4(), content: shuffledEmojis[i]));
      deck.add(EmojiCard(id: _uuid.v4(), content: shuffledEmojis[i]));
    }

    deck.shuffle();
    state = deck;
  }

  void flipCard(String id) {
    state = [
      for (final card in state)
        if (card.id == id)
          EmojiCard(id: card.id, content: card.content, faceUp: !card.faceUp)
        else
          card,
    ];
  }
}

class EmojiCard {
  EmojiCard({required this.id, required this.content, this.faceUp = false});
  final String id;
  final String content;
  final bool faceUp;
}
