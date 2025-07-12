import 'dart:math';
import 'dart:ui';

import 'package:baby_animals_app/main/chains.dart';
import 'package:flutter/material.dart';
import 'package:baby_animals_app/l10n/app_localizations.dart';

// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
class FullScreenModal extends ModalRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var angle = atan2(width, height);
    double alignx = 0;
    double aligny = 0;

    return Material(
      type: MaterialType.transparency,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            OverflowBox(
              alignment: Alignment(alignx,
                  aligny), // gives you top left portion of the size above, (1,1) gives bottom right, right direction is positive x, downward direction is positive y, see about Alignment on flutter docs for more details
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Transform.rotate(
                angle: -angle,
                child: Chains(),
              ),
            ),
            OverflowBox(
              alignment: Alignment(alignx,
                  aligny), // gives you top left portion of the size above, (1,1) gives bottom right, right direction is positive x, downward direction is positive y, see about Alignment on flutter docs for more details
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Transform.rotate(
                angle: angle,
                child: Chains(),
              ),
            ),
            Center(
              child: TapRegion(
                onTapOutside: (PointerDownEvent event) {
                  Navigator.pop(context);
                },
                onTapInside: (PointerDownEvent event) {
                  Navigator.pop(context, AppLocalizations.of(context).unlock);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/images/lock.png",
                    height: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
