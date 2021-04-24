import 'dart:async';

import 'package:calculator/calculation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(),
            Keyboard(),
          ],
        ),
      ),
    );
  }
}

//　表示
class TextField extends StatefulWidget {
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  String _expression = '';

  void _UpdateText(String letter) {
    setState(() {
      if (letter == '=' || letter == 'C')
        _expression = '';
      else
        _expression += letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(_expression, style: TextStyle(fontSize: 64.0)),
        ),
      ),
    );
  }

  static final controller = StreamController<String>();
  @override
  void initState() {
    controller.stream.listen((event) => _UpdateText(event));
    controller.stream.listen((event) => Calculation.GetKey(event));
  }
}

//==============================================================================
// キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const list = [
      '7',
      '8',
      '9',
      '÷',
      '4',
      '5',
      '6',
      '×',
      '1',
      '2',
      '3',
      '-',
      'C',
      '0',
      '=',
      '+'
    ];

    return Expanded(
        flex: 2,
        child: Center(
            child: Container(
          color: Colors.white,
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            children: list.map((key) {
              return GridTile(
                child: Button(key),
              );
            }).toList(),
          ),
        )));
  }
}

// キーボタン
class Button extends StatelessWidget {
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
      child: Center(
        child: Text(
          _key,
          style: TextStyle(fontSize: 46.0),
        ),
      ),
      color: Colors.white,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      onPressed: () {
        _TextFieldState.controller.sink.add(_key);
      },
    ));
  }
}
