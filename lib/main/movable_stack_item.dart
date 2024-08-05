import 'package:after_layout/after_layout.dart';
import 'package:baby_animals_app/animals/animals.dart';
import 'package:baby_animals_app/audio/audio_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';

class MovableStackItem extends StatefulWidget {
  const MovableStackItem({
    required super.key,
    required this.onDragEnd,
    required this.animal,
    required this.left,
    required this.top,
  });

  final double top;
  final double left;
  final Function(MovableStackItem) onDragEnd;
  final Animal animal;

  @override
  State<StatefulWidget> createState() {
    return _MovableStackItemState();
  }
}

class _MovableStackItemState extends State<MovableStackItem>
    with AfterLayoutMixin {
  double xPosition = 0;
  double yPosition = 0;

  final Size bigRectSize = Size(150, 150);
  final double feedbackScale = 0.5;

  @override
  void initState() {
    yPosition = widget.top;
    xPosition = widget.left;
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _audioController = Provider.of<AudioController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();
    var animal = widget.animal;

    return FutureBuilder(
        future: ScalableImage.fromSvgAsset(rootBundle, animal.image),
        builder: (context, snapshot) {
          var svg = snapshot.hasData
              ? ScalableImageWidget(
                  si: snapshot.data!,
                )
              : SizedBox();
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
              onDragStarted: () {
                audioController.playSfx(
                  SfxType.assets,
                  asset: animal.soundName,
                );
                audioController.playSfx(
                  SfxType.assets,
                  asset: animal.soundOfAnimal,
                );
              },
              onDragEnd: (dragDetails) {
                setState(() {
                  xPosition = dragDetails.offset.dx -
                      bigRectSize.width * feedbackScale / 2;
                  yPosition = dragDetails.offset.dy -
                      bigRectSize.height * feedbackScale / 2 -
                      (!kIsWeb ? 20 : 0);
                });
                widget.onDragEnd(widget);
              },
            ),
          );
        });
  }
}
