import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EmojiGame(7),
      child: const MyApp(),
    ),
  );
}

class EmojiGame extends ChangeNotifier {
  final emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];
  final _deck = <String>[];

  UnmodifiableListView<String> get deck => UnmodifiableListView(_deck);

  EmojiGame(int numberOfPairs) {
    final pairCount =
        numberOfPairs > emojis.length ? emojis.length : numberOfPairs;

    var shuffledEmojis = emojis;
    shuffledEmojis.shuffle();

    for (var i = 0; i < pairCount; i++) {
      _deck.add(shuffledEmojis[i]);
      _deck.add(shuffledEmojis[i]);
    }

    _deck.shuffle();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Memorize - Flutter Edition'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: GridView.extent(
            maxCrossAxisExtent: 150,
            padding: const EdgeInsets.all(4),
            mainAxisSpacing: 12,
            crossAxisSpacing: 8,
            childAspectRatio: 12 / 16,
            children: _buildGridTileList(10)),
      ),
    );
  }

  List<Widget> _buildGridTileList(int count) => List.generate(
      count,
      (i) => Container(
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
              emojis[i],
              textScaleFactor: 4,
            )),
          ));
}
