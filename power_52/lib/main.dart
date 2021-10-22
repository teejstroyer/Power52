import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: Center(child: GameBoard())),
    );
  }
}

class GameBoard extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  GameBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Array Length-1 minus index will give you inversed index.

    return Container(
      color: Colors.black,
      child: AspectRatio(
          aspectRatio: 1 / 1,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: 16,
            itemBuilder: (_, index) => Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Center(child: Text(index.toString())),
            ),
          )),
    );
  }
}
