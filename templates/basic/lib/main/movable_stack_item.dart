import 'package:basic/animals/animals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';

class MovableStackItem extends StatefulWidget {
  const MovableStackItem({
    required super.key,
    required this.onDragEnd,
    required this.animal,
  });

  final Function(MovableStackItem) onDragEnd;
  final Animal animal;

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
    var animal = widget.animal;

    return FutureBuilder(
        future: ScalableImage.fromSvgAsset(rootBundle, animal.image),
        builder: (context, snapshot) {
          var svg = snapshot.hasData
              ? ScalableImageWidget(
                  si: snapshot.data!,
                )
              : Center(
                  child: Text(
                    "Image with ${animal.type.name} not found!",
                    textAlign: TextAlign.center,
                  ),
                );
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: animal.backGroundColor,
                ),
                width: bigRectSize.width * feedbackScale,
                height: bigRectSize.height * feedbackScale,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: svg,
                ),
              ),
              childWhenDragging: SizedBox.shrink(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: animal.backGroundColor,
                ),
                width: bigRectSize.width,
                height: bigRectSize.height,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: svg,
                ),
              ),
              onDragUpdate: (DragUpdateDetails details) {},
              onDraggableCanceled: (velocity, offset) {},
              onDragCompleted: () {},
              onDragStarted: () {},
              onDragEnd: (dragDetails) {
                setState(() {
                  xPosition = dragDetails.offset.dx -
                      bigRectSize.width * feedbackScale / 2;
                  yPosition = dragDetails.offset.dy -
                      bigRectSize.height * feedbackScale / 2;
                });
                widget.onDragEnd(widget);
              },
            ),
          );
        });
  }
}
