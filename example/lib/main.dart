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
      theme: ThemeData.dark(),
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
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              exampleField(
                color: Colors.blue,
                action: TextInputAction.next,
                order: 0,
              ),
              exampleField(
                color: Colors.purple[200],
                action: TextInputAction.next,
                order: 1,
              ),
              exampleField(
                color: Colors.red[200],
                action: TextInputAction.next,
                order: 2,
              ),
              exampleField(
                color: Colors.orange[200],
                action: TextInputAction.next,
                order: 3,
              ),
              exampleField(
                color: Colors.yellow[100],
                order: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget exampleField({
    TextInputAction? action,
    Color? color,
    bool? autocorrect,
    double? order,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FocusTraversalOrder(
        order: NumericFocusOrder(order ?? 0),
        child: TextField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          autocorrect: autocorrect ?? true,
          textInputAction: action,
        ),
      ),
    );
  }
}
