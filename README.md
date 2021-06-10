
# avoid_keyboard

[![pub version](https://img.shields.io/pub/v/avoid_keyboard)](https://pub.dev/packages/avoid_keyboard)
[![pub points](https://badges.bar/avoid_keyboard/pub%20points)](https://pub.dev/packages/avoid_keyboard/score)
[![likes](https://badges.bar/avoid_keyboard/likes)](https://pub.dev/packages/avoid_keyboard/score)
[![popularity](https://badges.bar/avoid_keyboard/popularity)](https://pub.dev/packages/avoid_keyboard/score)

The `avoid_keyboard` package includes a widget (`AvoidKeyboard`) in which you can wrap your text fields and other input controls, such that they will scroll out of the way when the keyboard pops up. Using this widget has an advantage over using the default `Scaffold` behavior, in that you can specify exactly which areas of your app will scroll in response to the keyboard, rather than having your entire viewport compressed (which won't work anyway for fixed height columns). 

Another advantage, is that AvoidKeyboard will only shift its contents in the case that the keyboard is actually overlapping the focused input control.

<p align="center">
  <img alt="demonstration gif" height="450" src="https://user-images.githubusercontent.com/6050603/121590626-61318700-c9ed-11eb-86f2-0da2a3dc025b.gif">
</p>

## Getting Started

To get started, simply wrap the input controls (along with any surrounding portion of the widget tree which should move out of the way):

```dart
class AvoidKeyboardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AvoidKeyboard(
      child: Column(
        children: [
          TextField(),
          TextField(),
        ],
      ),
    );
  }
}
```

Having done this, the view will now scroll out of the way when the keyboard overlaps an active control.
