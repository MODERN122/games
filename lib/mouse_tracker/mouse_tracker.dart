import 'package:baby_animals_app/mouse_tracker/mouse_tracker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MouseTracker extends StatefulWidget {
  const MouseTracker({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<MouseTracker> createState() => _MouseTrackerState();
}

class _MouseTrackerState extends State<MouseTracker> {
  @override
  Widget build(BuildContext context) {
    final mouseTracker = context.watch<MouseTrackerProvider>();

    return MouseRegion(
      onHover: (event) {
        mouseTracker.setCoordinates(event.position.dx, event.position.dy);
      },
      child: widget.child,
    );
  }
}
