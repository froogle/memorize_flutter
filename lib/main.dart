import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class EmojiGame {
  final emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];
  var deck = <String>[];

  EmojiGame(int numberOfPairs) {
    final pairCount =
        numberOfPairs > emojis.length ? emojis.length : numberOfPairs;

    var shuffledEmojis = emojis;
    shuffledEmojis.shuffle();

    for (var i = 0; i < pairCount; i++) {
      deck.add(shuffledEmojis[i]);
      deck.add(shuffledEmojis[i]);
    }

    deck.shuffle();
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
      home: const MyHomePage(title: 'Memorize - Flutter Edition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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

  var emojis = ["✈️", "🚀", "🚘", "🚎", "🚛", "🚐", "⛴", "🏍", "🚁", "🚂"];

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
