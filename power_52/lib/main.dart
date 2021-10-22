import 'package:flutter/material.dart';
import 'package:power_52/dbservice.dart';

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
      home: Scaffold(
          body: Column(
        children: [
          Container(
            color: Colors.red,
            child: TextButton(
              onPressed: () => {DBService.addUser("Bill")},
              child: const Text('Add User'),
            ),
          ),
        ],
      )),
    );
  }
}
