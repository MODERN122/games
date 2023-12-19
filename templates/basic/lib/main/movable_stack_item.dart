import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class MovableStackItem extends StatefulWidget {
  const MovableStackItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MovableStackItemState();
  }
}

class _MovableStackItemState extends State<MovableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color = Colors.red;
  @override
  void initState() {
    var randomColor = RandomColor().randomColor();
    color = randomColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: Draggable(
        feedback: Container(
          width: 50,
          height: 50,
          color: color,
        ),
        childWhenDragging: SizedBox.shrink(),
        child: Container(
          width: 150,
          height: 150,
          color: color,
        ),
        onDragStarted: () {},
        onDragEnd: (dragDetails) {
          // 10.
          setState(() {
            xPosition = dragDetails.offset.dx;
            yPosition = dragDetails.offset.dy;
          });
        },
      ),
    );
  }
}
