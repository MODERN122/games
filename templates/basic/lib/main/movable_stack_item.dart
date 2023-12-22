import 'package:basic/mouse_tracker/mouse_tracker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class MovableStackItem extends StatefulWidget {
  MovableStackItem({super.key, this.onDragEnd});

  final Function(MovableStackItem)? onDragEnd;

  Color color = RandomColor().randomColor();

  @override
  State<StatefulWidget> createState() {
    return _MovableStackItemState();
  }
}

class _MovableStackItemState extends State<MovableStackItem> {
  double xPosition = 0;
  double yPosition = 0;

  final Size bigRectSize = Size(150, 150);
  final double feedbackScale = 0.5;
  final GlobalKey _widgetKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  void getPositions(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      return;
    }

    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: Draggable(
        dragAnchorStrategy: (draggable, context, position) {
          var feedback = draggable.feedback as Container;
          var constraints = feedback.constraints;
          if (constraints == null) {
            return Offset(0, 0);
          }
          return Offset(
            constraints.minWidth / 2,
            constraints.maxHeight / 2,
          );
        },
        feedback: Container(
          key: _widgetKey,
          width: bigRectSize.width * feedbackScale,
          height: bigRectSize.height * feedbackScale,
          color: widget.color,
        ),
        childWhenDragging: SizedBox.shrink(),
        child: Container(
          width: bigRectSize.width,
          height: bigRectSize.height,
          color: widget.color,
        ),
        onDragUpdate: (DragUpdateDetails details) {},
        onDraggableCanceled: (velocity, offset) {},
        onDragCompleted: () {},
        onDragStarted: () {},
        onDragEnd: (dragDetails) {
          // 10.
          setState(() {
            xPosition =
                dragDetails.offset.dx - bigRectSize.width * feedbackScale / 2;
            yPosition =
                dragDetails.offset.dy - bigRectSize.height * feedbackScale / 2;
          });
          if (widget.onDragEnd != null) {
            widget.onDragEnd!(widget);
          }
        },
      ),
    );
  }
}
