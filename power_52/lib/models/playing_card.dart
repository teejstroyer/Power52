import 'package:flutter/material.dart';
import 'package:power_52/widgets/playing_card_widget.dart';
import 'package:power_52/widgets/hero_card_widget.dart';

class PlayingCard {
  Suit suit;
  Rank rank;
  bool faceUp;
  bool isEnemy;
  List<PlayingCard> powerCards = [];
  PlayingCard({required this.suit, required this.rank, this.isEnemy = false, this.faceUp = false});

  String rankToString() {
    switch (rank) {
      case Rank.ace:
        return "A";
      case Rank.ten:
        return "X";
      case Rank.jack:
        return "J";
      case Rank.queen:
        return "Q";
      case Rank.king:
        return "K";
      default:
        return rankToInt().toString();
    }
  }

  int rankToInt() {
    switch (rank) {
      case Rank.two:
        return 2;
      case Rank.three:
        return 3;
      case Rank.four:
        return 4;
      case Rank.five:
        return 5;
      case Rank.six:
        return 6;
      case Rank.seven:
        return 7;
      case Rank.eight:
        return 8;
      case Rank.nine:
        return 9;
      case Rank.ten:
        return 10;
      case Rank.jack:
        return 11;
      case Rank.queen:
        return 12;
      case Rank.king:
        return 13;
      case Rank.ace:
        return 1;
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
  String toString() => "${rankToString()}${suitToString()}";

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

enum Rank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace,
}
