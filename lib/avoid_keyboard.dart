import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A wrapper widget which will scroll out of the way when the keyboard is showing,
/// given the keyboard overlaps an active input control which is a descendent of [child].
///
/// To use, first generate a list of [FocusNode] objects - these will be passed to both
/// the wrapped input controls, and to [AvoidKeyboard] itself. [AvoidKeyboard] will then
/// listen to changes on these nodes, and when one is focused, it will then determine
/// whether the rect property on the [FocusNode] is overlapping with the bottom inset.
/// If so, the view will be scrolled upward accordingly.
///
/// Example:
/// ```dart
/// class AvoidKeyboardExample extends StatelessWidget {
///   // Initialize a focus node for each input control
///   final focusNodes = [
///     FocusNode(),
///     FocusNode()
///   ];
///
///   @override
///   Widget build(BuildContext context) {
///     return AvoidKeyboard(
///       focusNodes: focusNodes, // Pass the FocusNodes to the AvoidKeyboard widget
///       child: Column(
///         children: [
///           TextField(
///             focusNode: focusNodes[0],
///           ),
///           TextField(
///             focusNode: focusNodes[1],
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
///
class AvoidKeyboard extends StatefulWidget {
  /// A list of FocusNode objects (there should be one for each input control).
  final List<FocusNode> focusNodes;

  /// The child to wrap.
  final Widget child;

  /// The space between the active input control and the top of the keyboard.
  /// Must be >= 0.
  final double? spacing;

  final _scrollController = ScrollController();

  AvoidKeyboard({required this.focusNodes, required this.child, this.spacing});

  @override
  _AvoidKeyboardState createState() => _AvoidKeyboardState();
}

class _AvoidKeyboardState extends State<AvoidKeyboard> {
  FocusNode? _currentlyFocusedNode;
  double _offset = 0;

  double get _spacing => (widget.spacing ?? 0) < 0 ? 0 : widget.spacing ?? 0;

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

            _offset = currentScrollOffset + overlap + _spacing;
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
