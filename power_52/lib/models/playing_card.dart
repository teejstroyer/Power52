import 'package:flutter/material.dart';
import 'package:power_52/widgets/playing_card_widget.dart';
import 'package:power_52/widgets/hero_card_widget.dart';

class PlayingCard {
  Suit suit;
  int value;
  bool faceUp;
  bool isEnemy;
  List<PlayingCard> powerCards = [];
  PlayingCard({required this.suit, required this.value, this.isEnemy = false, this.faceUp = false});

  String valueToString() {
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

  String suitToString() {
    switch (suit) {
      case Suit.club:
        return "♣";
      case Suit.diamond:
        return "♦";
      case Suit.heart:
        return "♥";
      case Suit.spade:
        return "♠";
    }
  }

  Color suitColor() {
    switch (suit) {
      case Suit.club:
      case Suit.spade:
        return Colors.black;
      case Suit.diamond:
      case Suit.heart:
        return Colors.red;
    }
  }

  @override
  String toString() => "${valueToString()}${suitToString()}";

  // Generates A Game Card Size tall by 1/2 Size Wide
  PlayingCardWidget toPlayingCardWidget(double size) => PlayingCardWidget(playingCard: this, size: size);
  // Generates A Hero Card Size tall by 1/2 Size Wide
  HeroCardWidget toHeroCardWidget(double size, Function cardMoved) => HeroCardWidget(playingCard: this, size: size, cardMoved: cardMoved);
}

enum Suit {
  heart,
  spade,
  club,
  diamond,
}
