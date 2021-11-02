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
          final deck = watch.watch(gameProvider);
          return Center(child: gridOfPlayingCards(deck));
        }));
  }

  GridView gridOfPlayingCards(List<PlayingCard> deck) {
    return GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        childAspectRatio: 12 / 16,
        children: List.generate(
            deck.length, (i) => PlayingCardWidget(card: deck[i])));
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
    return Container(
      decoration: exposedGameCard(),
      child: Center(child: Text(card.content, textScaleFactor: 4)),
    );
  }

  BoxDecoration exposedGameCard() {
    return BoxDecoration(
      color: Colors.white,
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
