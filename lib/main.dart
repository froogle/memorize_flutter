import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'Models/emoji_game_model.dart';

void main() {
  runApp(const ProviderScope(child: MemorizeApp()));
}

class MemorizeApp extends StatelessWidget {
  const MemorizeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainGame(title: 'Memorize - Flutter Edition'),
    );
  }
}

class MainGame extends StatefulWidget {
  const MainGame({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer(builder: (ctx, watch, child) {
          final deckOfCards = watch.watch(gameProvider);
          return Center(child: gridOfPlayingCards(deckOfCards));
        }));
  }

  GridView gridOfPlayingCards(List<PlayingCard> deckOfCards) {
    return GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        childAspectRatio: 12 / 16,
        children: List.generate(deckOfCards.length,
            (i) => PlayingCardWidget(card: deckOfCards[i])));
  }
}

class PlayingCardWidget extends StatelessWidget {
  const PlayingCardWidget({
    Key? key,
    required this.card,
  }) : super(key: key);

  final PlayingCard card;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, watch, child) {
      return Container(
          decoration: card.faceUp ? exposedGameCard() : hiddenGameCard(),
          child: TextButton(
            child: Text(card.faceUp ? card.faceValue : "", textScaleFactor: 4),
            onPressed: () => watch.read(gameProvider.notifier).flipCard(card),
          ));
    });
  }

  BoxDecoration exposedGameCard() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [cardShadow()],
    );
  }

  BoxDecoration hiddenGameCard() {
    return BoxDecoration(
      color: Colors.red,
      border: Border.all(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [cardShadow()],
    );
  }

  BoxShadow cardShadow() {
    return BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 2));
  }
}
