import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class MovableStackItem extends StatefulWidget {
  MovableStackItem({required super.key, required this.onDragEnd});

  final Function(MovableStackItem) onDragEnd;
  final Color color = RandomColor().randomColor();

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: Draggable(
        data: widget,
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
          setState(() {
            xPosition =
                dragDetails.offset.dx - bigRectSize.width * feedbackScale / 2;
            yPosition =
                dragDetails.offset.dy - bigRectSize.height * feedbackScale / 2;
          });
          widget.onDragEnd(widget);
        },
      ),
    );
  }
}
