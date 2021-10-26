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
      child: getCard(size),
      feedback: getCard(size),
      childWhenDragging: const SizedBox.shrink(),
      onDragCompleted: () {
        cardMoved();
      },
    );
  }

  Widget getCard(double size) => Center(
        child: Container(
          color: Colors.red,
          width: size / 2,
          height: size,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Text(playingCard.toString()),
            ),
          ),
        ),
      );
}
