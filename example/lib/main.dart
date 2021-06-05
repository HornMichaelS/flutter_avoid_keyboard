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
      title: 'Avoid Keyboard Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Avoid Keyboard Example")),
        body: AvoidKeyboardExample(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class AvoidKeyboardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AvoidKeyboard(
      spacing: 40,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(),
            TextField(),
            TextField(),
            TextField(),
            TextField(),
          ],
        ),
      ),
    );
  }
}
