import 'package:flutter/material.dart';
import 'package:power_52/widgets/playing_card_widget.dart';
import 'package:power_52/models/playing_card.dart';

class HeroCardWidget extends StatelessWidget {
  final Function cardMoved;
  final double size;
  final PlayingCard playingCard;
  final PlayingCardWidget playingCardWidget;

  HeroCardWidget({Key? key, required this.size, required this.playingCard, required this.cardMoved})
      : playingCardWidget = playingCard.toPlayingCardWidget(size),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: playingCard,
      child: getHeroCardWidget(),
      feedback: getHeroCardWidget(),
      childWhenDragging: Container(), //const SizedBox.shrink(),
      onDragCompleted: () => cardMoved(),
    );
  }

  Widget getHeroCardWidget() {
    return SizedBox(
      width: size,
      height: size,
      child: RotatedBox(
        quarterTurns: playingCard.isEnemy ? 2 : 0,
        child: playingCardWidget,
      ),
    );
  }
}
