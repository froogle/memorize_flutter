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
          return Center(child: cardList(deck));
        }));
  }

  GridView cardList(List<EmojiCard> deck) {
    return GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        childAspectRatio: 12 / 16,
        children: _buildGridTileList(deck.length, deck));
  }

  List<Widget> _buildGridTileList(int count, List<EmojiCard> deck) =>
      List.generate(count, (i) => GameCard(cardFace: deck[i].content));
}

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required this.cardFace,
  }) : super(key: key);

  final String cardFace;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: exposedGameCard(),
      child: Center(child: Text(cardFace, textScaleFactor: 4)),
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
