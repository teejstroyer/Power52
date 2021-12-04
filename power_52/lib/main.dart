import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:power_52/widgets/hero_card_widget.dart';
import 'models/playing_card.dart';
//import 'package:power_52/screens/game_board.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Scaffold(body: Center(child: GameBoard())),

      home: Scaffold(
        body: Column(
          children: [
            Expanded(flex: 1, child: Container(color: Colors.green)),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                  child: GameGrid(gridSize: 4),
                )),
            Expanded(flex: 1, child: Container(color: Colors.yellow)),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GameGrid extends StatefulWidget {
  final int gridSize;
  late String layout = '';

  GameGrid({Key? key, required this.gridSize}) : super(key: key) {
    for (int i = 0; i < gridSize; i++) {
      layout += ".";
      for (int j = 0; j < gridSize - 1; j++) {
        layout += " .";
      }
      layout += "\n";
    }
  }
  @override
  State<StatefulWidget> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  late List<List<PlayingCard?>> grid;
  @override
  void initState() {
    super.initState();

    grid = List.generate(
      widget.gridSize,
      (i) => List.generate(widget.gridSize, (index) => null, growable: false),
      growable: false,
    );

    grid[2][2] = PlayingCard(
      suit: Suit.spade,
      rank: Rank.ace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var w = constraints.biggest.shortestSide;
        double gapSize = 5;
        var size = w / widget.gridSize - (gapSize * (widget.gridSize - 1)) / widget.gridSize;
        return SizedBox(
          width: w,
          height: w,
          child: LayoutGrid(
            rowGap: gapSize,
            columnGap: gapSize,
            columnSizes: repeat(widget.gridSize, [size.px]),
            rowSizes: repeat(widget.gridSize, [size.px]),
            children: [
              for (var x = 0; x < widget.gridSize; x++)
                for (var y = 0; y < widget.gridSize; y++)
                  Center(
                    child: DragTarget(
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
                      builder: (BuildContext context, List<PlayingCard?> candidateData, List<dynamic> rejectedData) {
                        return Container(
                          color: Colors.redAccent,
                          child: grid[x][y] == null
                              ? Container()
                              : HeroCardWidget(
                                  size: size,
                                  playingCard: grid[x][y] as PlayingCard,
                                  cardMoved: () {
                                    setState(() {
                                      grid[x][y] = null;
                                    });
                                  },
                                ),
                        ).withGridPlacement(columnStart: x, rowStart: y);
                      },
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
