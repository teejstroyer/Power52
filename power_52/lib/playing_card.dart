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

  @override
  String toString() => "${valueToString()}${suitToString()}";
}

enum Suit {
  heart,
  spade,
  club,
  diamond,
}
