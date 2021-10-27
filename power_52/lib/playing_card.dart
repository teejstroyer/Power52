import 'package:flutter/material.dart';

class PlayingCard {
  Suit suit;
  int value;
  PlayingCard(this.suit, this.value);

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
}

enum Suit {
  heart,
  spade,
  club,
  diamond,
}
