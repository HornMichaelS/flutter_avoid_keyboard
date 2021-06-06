import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A wrapper widget which will scroll out of the way when the keyboard is showing,
/// given the keyboard overlaps an active input control which is a descendent of [child].
///
/// To use, simply wrap the elements which you want to avoid the keyboard within the
/// [AvoidKeyboard] widget. The widget will automatically detect when input elements
/// become active and scroll the viewport accordingly.
///
/// Example:
/// ```dart
/// class AvoidKeyboardExample extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AvoidKeyboard(
///       child: Column(
///         children: [
///           TextField(),
///           TextField(),
///         ],
///       ),
///     );
///   }
/// }
/// ```
class AvoidKeyboard extends StatefulWidget {
  /// The child to wrap.
  final Widget child;

  @deprecated
  final List<FocusNode>? focusNodes;

  /// The space between the active input control and the top of the keyboard.
  /// Must be >= 0.
  final double? spacing;

  AvoidKeyboard({
    required this.child,
    @deprecated this.focusNodes,
    this.spacing,
  });

  @override
  _AvoidKeyboardState createState() => _AvoidKeyboardState();
}

class _AvoidKeyboardState extends State<AvoidKeyboard> {
  final _focusNode = FocusNode();

  double _offset = 0;

  double get _spacing => (widget.spacing ?? 0) < 0 ? 0 : widget.spacing ?? 0;

  @override
  void initState() {
    _focusNode.addListener(() async {
      if (_focusNode.hasFocus) {
        _handleFocus();
      } else {
        _handleLoseFocus();
      }
    });

    super.initState();
  }

  void _handleFocus() async {
    FocusNode primaryNode;

    try {
      primaryNode = _focusNode.traversalDescendants
          .firstWhere((element) => element.hasPrimaryFocus);
    } catch (_) {
      return;
    }

    // Wait for the bottom inset to update
    await waitForKeyboardFrameUpdate();

    final viewPortBottom = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom -
        _spacing;
    final nodeBottom = primaryNode.rect.bottom;

    if (nodeBottom > viewPortBottom) {
      final overlap = nodeBottom - viewPortBottom;

      setState(() {
        _offset = overlap;
      });
    }
  }

  // The keyboard frame will not update immediately upon focus, therefore
  // we need to see a change in the bottom inset, before scrolling the viewport.
  Future<void> waitForKeyboardFrameUpdate() {
    final completer = Completer();
    final currentBottomInset = MediaQuery.of(context).viewInsets.bottom;

    final timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      final newBottomInset = MediaQuery.of(context).viewInsets.bottom;

      if (currentBottomInset != newBottomInset) {
        completer.complete();
      }
    });

    return completer.future
        .timeout(Duration(milliseconds: 500))
        .whenComplete(() => timer.cancel());
  }

  void _handleLoseFocus() async {
    setState(() {
      _offset = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: ClipRect(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 160),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(0, -_offset, 0),
          child: widget.child,
        ),
      ),
    );
  }
}
