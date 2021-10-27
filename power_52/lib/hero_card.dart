import 'package:flutter/material.dart';
import 'package:power_52/playing_card.dart';

class HeroCard extends StatelessWidget {
  final double size;
  final PlayingCard playingCard;
  final Function cardMoved;
  const HeroCard({Key? key, required this.size, required this.playingCard, required this.cardMoved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: playingCard,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          getCard(size),
          RotatedBox(quarterTurns: 1, child: getCard(size)),
        ],
      ),
      feedback: getCard(size),
      childWhenDragging: const SizedBox.shrink(),
      onDragCompleted: () {
        cardMoved();
      },
    );
  }

  Widget getCard(double size) => GameCard(playingCard: playingCard, size: size);
}

class GameCard extends StatelessWidget {
  final double size;
  const GameCard({
    Key? key,
    required this.playingCard,
    required this.size,
  }) : super(key: key);

  final PlayingCard playingCard;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(3),
        width: size / 2,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black, width: 2),
          // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
          //boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(0, 0))],
          // ignore: prefer_const_constructors
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              // ignore: prefer_const_constructors
              Colors.blueGrey,
              // ignore: prefer_const_constructors
              Colors.blueGrey[200] as Color,
              // ignore: prefer_const_constructors
              Colors.blueGrey,
            ],
          ),
        ),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                playingCard.toString(),
                style: TextStyle(color: playingCard.suitColor(), fontSize: size),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
