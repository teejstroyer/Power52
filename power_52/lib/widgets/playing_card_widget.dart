import 'package:flutter/material.dart';
import 'package:power_52/models/playing_card.dart';

class PlayingCardWidget extends StatelessWidget {
  final double size;
  final PlayingCard playingCard;
  const PlayingCardWidget({
    Key? key,
    required this.playingCard,
    required this.size,
  }) : super(key: key);

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
          //boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(0, 0))],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey,
              Colors.blueGrey[200] as Color,
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
