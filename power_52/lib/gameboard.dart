import 'dart:math';
import 'package:flutter/material.dart';

const List<Suit> suits = [Suit.CLUB, Suit.DIAMOND, Suit.HEART, Suit.SPADE];
const List<int> powerCardValues = [2, 3, 4, 5, 6, 7, 8, 9];
const List<int> heroCardValues = [1, 10, 11, 12, 13];

class GameBoard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final List<List<PlayingCard?>> grid = [];
  @override
  Widget build(BuildContext context) {
    //Array Length-1 minus index will give you inversed index.
    var screenSize = MediaQuery.of(context).size;
    int gridSize = 4;
    var size = ([screenSize.height, screenSize.width].reduce(min) / gridSize);
    return Column(
      children: [
        Expanded(child: Container(color: Colors.green)),
        getGrid(gridSize, size),
        Expanded(
          child: Row(
            children: [
              HeroCard(size: size * .9, playingCard: PlayingCard(Suit.DIAMOND, 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget getGrid(int gridSize, double size) {
    var boxDecoration = BoxDecoration(color: Colors.yellow, border: Border.all(color: Colors.black, width: 3));
    List<Row> rows = [];
    for (int y = 0; y < gridSize; y++) {
      List<Widget> row = [];
      for (int x = 0; x < gridSize; x++) {
        row.add(DragTarget(
          builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
            return Container(
              decoration: boxDecoration,
              child: grid[x][y] == null
                  ? const SizedBox.shrink()
                  : HeroCard(
                      size: size,
                      playingCard: grid[x][y] as PlayingCard,
                    ),
            );
          },
        ));
      }
      rows.add(Row(children: row));
    }
    return Column(children: rows);
  }
}

class HeroCard extends StatelessWidget {
  final double size;
  final PlayingCard playingCard;
  const HeroCard({Key? key, required this.size, required this.playingCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: getCard(size),
      feedback: getCard(size),
      childWhenDragging: const SizedBox.shrink(),
    );
  }

  Material getCard(double size) => Material(
        child: Container(
          color: Colors.pink,
          width: size / 2,
          height: size,
          child: Center(
            child: Text(playingCard.toString()),
          ),
        ),
      );
}

class PlayingCard {
  Suit suit;
  int value;
  PlayingCard(this.suit, this.value);

  valueToString() {
    switch (value) {
      case 1:
        return "A";
      case 10:
        return "X";
      case 11:
        return "J";
      case 12:
        return "Q";
      case 13:
        return "K";
      default:
        return value.toString();
    }
  }

  suitToString() {
    switch (suit) {
      case Suit.CLUB:
        return "♣";
      case Suit.DIAMOND:
        return "♦";
      case Suit.HEART:
        return "♥";
      case Suit.SPADE:
        return "♠";
    }
  }

  @override
  String toString() => "${valueToString()}${suitToString()}";
}

enum Suit {
  // ignore: constant_identifier_names
  HEART,
  // ignore: constant_identifier_names
  SPADE,
  // ignore: constant_identifier_names
  CLUB,
  // ignore: constant_identifier_names
  DIAMOND,
}
