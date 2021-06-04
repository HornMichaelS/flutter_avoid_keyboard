library avoid_keyboard;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AvoidKeyboard extends StatefulWidget {
  final List<FocusNode> focusNodes;
  final Widget child;

  final _scrollController = ScrollController();

  AvoidKeyboard({required this.focusNodes, required this.child});

  @override
  _AvoidKeyboardState createState() => _AvoidKeyboardState();
}

class _AvoidKeyboardState extends State<AvoidKeyboard> {
  FocusNode? _currentlyFocusedNode;
  double _offset = 0;

  @override
  void initState() {
    super.initState();

    createNodeListeners();
  }

  @override
  void didUpdateWidget(AvoidKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);

    createNodeListeners();
  }

  void createNodeListeners() {
    for (final focusNode in widget.focusNodes) {
      focusNode.addListener(() async {
        await Future.delayed(Duration(milliseconds: 100));

        final currentScrollOffset = widget._scrollController.offset;

        if (focusNode.hasFocus) {
          _currentlyFocusedNode = focusNode;
          final viewPortBottom = MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom;
          final nodeBottom = focusNode.rect.bottom;

          if (nodeBottom > viewPortBottom) {
            final overlap = nodeBottom - viewPortBottom;

            _offset = currentScrollOffset + overlap + 40;
            widget._scrollController.animateTo(
              _offset,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
        } else if (_currentlyFocusedNode == focusNode) {
          _currentlyFocusedNode = null;
          widget._scrollController.animateTo(
            currentScrollOffset - _offset,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
          _offset = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: widget._scrollController,
      axisDirection: AxisDirection.down,
      physics: NeverScrollableScrollPhysics(),
      viewportBuilder: (context, offset) => Viewport(
        offset: offset,
        cacheExtentStyle: CacheExtentStyle.pixel,
        slivers: [
          SliverFillViewport(
              delegate: SliverChildListDelegate.fixed([
            Container(
              child: widget.child,
            ),
            Container(),
          ])),
        ],
      ),
    );
  }
}
