import 'dart:math';
import 'package:flutter/material.dart';
import 'package:power_52/hero_card.dart';
import 'package:power_52/playing_card.dart';

const List<Suit> suits = [Suit.club, Suit.diamond, Suit.heart, Suit.spade];
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
  final List<PlayingCard> hand = [
    PlayingCard(Suit.diamond, 12),
    PlayingCard(Suit.club, 12),
    PlayingCard(Suit.heart, 12),
    PlayingCard(Suit.spade, 12),
  ];
  @override
  Widget build(BuildContext context) {
    //Array Length-1 minus index will give you inversed index.
    var screenSize = MediaQuery.of(context).size;
    int gridSize = 4;
    var size = ([screenSize.height, screenSize.width].reduce(min) / gridSize);
    var cardSize = size * .9;

    return Column(
      children: [
        Expanded(child: Container(color: Colors.green)),
        getGrid(gridSize, size, cardSize),
        Expanded(
          child: Center(
            child: SizedBox(
              height: cardSize,
              child: Row(
                children: hand
                    .map((card) => HeroCard(
                        playingCard: card,
                        size: cardSize,
                        cardMoved: () {
                          setState(
                            () {
                              hand.remove(card);
                            },
                          );
                        }))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      grid.add([]);
      for (int j = 0; j < 4; j++) {
        grid[i].add(null);
      }
    }
  }

  Widget getGrid(int gridSize, double size, double cardSize) {
    var boxDecoration = BoxDecoration(color: Colors.yellow, border: Border.all(color: Colors.black, width: 3));
    List<Row> rows = [];
    for (int y = 0; y < gridSize; y++) {
      List<Widget> row = [];
      for (int x = 0; x < gridSize; x++) {
        row.add(DragTarget(
          builder: (BuildContext context, List<PlayingCard?> candidateData, List<dynamic> rejectedData) {
            return Container(
              height: size,
              width: size,
              decoration: boxDecoration,
              child: grid[x][y] == null
                  ? const SizedBox.shrink()
                  : Center(
                      child: SizedBox(
                        height: cardSize,
                        width: cardSize / 2,
                        child: HeroCard(
                            size: cardSize,
                            playingCard: grid[x][y] as PlayingCard,
                            cardMoved: () {
                              setState(() {
                                grid[x][y] = null;
                              });
                            }),
                      ),
                    ),
            );
          },
          onWillAccept: (data) {
            return grid[x][y] == null;
          },
          onAccept: (data) {
            if (data != null) {
              setState(() {
                grid[x][y] = data as PlayingCard;
              });
            }
          },
        ));
      }
      rows.add(Row(children: row));
    }
    return Column(children: rows);
  }
}
