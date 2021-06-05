# avoid_keyboard

The `avoid_keyboard` package includes a widget (`AvoidKeyboard`) in which you can wrap your text fields and other input controls, such that they will scroll out of the way when the keyboard pops up. Using this widget has an advantage over using the default `Scaffold` behavior, in that you can specify exactly which areas of your app will scroll in response to the keyboard, rather than having your entire viewport compressed (which won't work anyway for fixed height columns). 

Another advantage, is that AvoidKeyboard will only shift its contents in the case that the keyboard is actually overlapping the focused input control.

<p align="center">
  <img height="450" src="https://user-images.githubusercontent.com/6050603/120873229-25fb0800-c556-11eb-89fc-fb97957be784.gif">
</p>

## Getting Started

In order to function correctly, the wrapper widget will need references to the focus nodes for each wrapped input control:

```dart
class AvoidKeyboardExample extends StatelessWidget {
  // Initialize a focus node for each input control
  final focusNodes = [
    FocusNode(),
    FocusNode()
  ];

  @override
  Widget build(BuildContext context) {
    return AvoidKeyboard(
      focusNodes: focusNodes, // Pass the FocusNodes to the AvoidKeyboard widget
      child: Column(
        children: [
          TextField(
            focusNode: focusNodes[0],
          ),
          TextField(
            focusNode: focusNodes[1],
          ),
        ],
      ),
    );
  }
}
```

Having done this, the view will now scroll out of the way when the keyboard overlaps an active control.
