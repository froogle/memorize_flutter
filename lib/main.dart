import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/emoji_game_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EmojiGameModel(7),
      child: const MemorizeApp(),
    ),
  );
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
      home: const MainGameWidget(title: 'Memorize - Flutter Edition'),
    );
  }
}

class MainGameWidget extends StatelessWidget {
  const MainGameWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<EmojiGameModel>(
      builder: (context, game, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: cardList(game),
          ),
        );
      },
    );
  }

  GridView cardList(EmojiGameModel game) {
    return GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        childAspectRatio: 12 / 16,
        children: _buildGridTileList(game.deck.length, game));
  }

  List<Widget> _buildGridTileList(int count, EmojiGameModel game) =>
      List.generate(count, (i) => ExposedCard(cardFace: game.deck[i]));
}

class ExposedCard extends StatelessWidget {
  const ExposedCard({
    Key? key,
    required this.cardFace,
  }) : super(key: key);

  final String cardFace;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red, width: 4),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2))
        ],
      ),
      child: Center(
          child: Text(
        cardFace,
        textScaleFactor: 4,
      )),
    );
  }
}
