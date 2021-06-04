import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Avoid Keyboard Example")),
        body: AvoidKeyboardExample(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class AvoidKeyboardExample extends StatelessWidget {
  final focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  Widget build(BuildContext context) {
    return AvoidKeyboard(
      focusNodes: focusNodes,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: focusNodes
              .map(
                (node) => TextField(
                  focusNode: node,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
