import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Chains extends StatelessWidget {
  const Chains({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1800,
      height: 1800,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          Positioned(top: 0, child: Chain()),
          Positioned(top: 150, child: Chain()),
          Positioned(top: 300, child: Chain()),
          Positioned(top: 450, child: Chain()),
          Positioned(top: 600, child: Chain()),
          Positioned(top: 750, child: Chain()),
          Positioned(top: 900, child: Chain()),
          Positioned(top: 1050, child: Chain()),
          Positioned(top: 1200, child: Chain()),
          Positioned(top: 1350, child: Chain()),
          Positioned(top: 1500, child: Chain()),
          Positioned(top: 1650, child: Chain()),
          Positioned(top: 1800, child: Chain()),
        ],
      ),
    );
  }
}

class Chain extends StatelessWidget {
  const Chain({super.key});

  @override
  Widget build(BuildContext context) {
    var angle = 3 * pi / 4;
    return Transform.rotate(
      angle: angle,
      child: Image.asset(
        "assets/images/chain.png",
        height: 150,
      ),
    );
  }
}
