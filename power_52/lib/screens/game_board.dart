import 'dart:math';
import 'package:flutter/material.dart';
import 'package:power_52/widgets/hero_card_widget.dart';
import 'package:power_52/models/playing_card.dart';

const List<Suit> suits = [Suit.club, Suit.diamond, Suit.heart, Suit.spade];
const List<int> powerCardValues = [2, 3, 4, 5, 6, 7, 8, 9];
const List<int> heroCardValues = [1, 10, 11, 12];
const int kingCardValue = 13;

class GameBoard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late int gridSize;
  // Cards
  List<List<PlayingCard?>> grid = [];
  List<PlayingCard> oponentHand = [];
  List<PlayingCard> hand = [];
  // Kings
  List<PlayingCard> kingCardPile = [];
  // Power Cards
  List<PlayingCard> powerCardPile = [];
  List<PlayingCard> discardPowerCardPile = [];
  // Hero Cards
  List<PlayingCard> heroCardPile = [];
  List<PlayingCard> discardHeroCardWidgetPile = [];

  @override
  void initState() {
    super.initState();
    gridSize = 4;
    for (int i = 0; i < gridSize; i++) {
      grid.add([]);
      for (int j = 0; j < gridSize; j++) {
        grid[i].add(null);
      }
    }

    for (var suit in suits) {
      for (var value in powerCardValues) {
        powerCardPile.add(PlayingCard(suit: suit, value: value));
      }
      for (var value in heroCardValues) {
        heroCardPile.add(PlayingCard(suit: suit, value: value));
      }
      kingCardPile.add(PlayingCard(suit: suit, value: kingCardValue));
    }

    powerCardPile.shuffle();
    heroCardPile.shuffle();
    kingCardPile.shuffle();

    oponentHand.add(kingCardPile.removeLast());
    oponentHand.add(heroCardPile.removeLast());
    oponentHand.add(heroCardPile.removeLast());

    hand.add(kingCardPile.removeLast());
    hand.add(heroCardPile.removeLast());
    hand.add(heroCardPile.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    //Array Length-1 minus index will give you inversed index.
    var screenSize = MediaQuery.of(context).size;
    var size = ([screenSize.height, screenSize.width].reduce(min) / gridSize);
    var cardSize = size * .9;

    return Column(
      children: [
        Expanded(child: Container(color: Colors.green)),
        getGrid(size, cardSize),
        getHand(cardSize),
      ],
    );
  }

  Widget getHand(double cardSize) {
    return Expanded(
      child: Center(
        child: SizedBox(
          height: cardSize,
          child: Row(
            children: hand.map((card) => card.toHeroCardWidget(cardSize, () => setState(() => hand.remove(card)))).toList(),
          ),
        ),
      ),
    );
  }

  Widget getGrid(double size, double cardSize) {
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
                      child: Container(
                        color: Colors.red,
                        clipBehavior: Clip.none,
                        child: HeroCardWidget(
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
