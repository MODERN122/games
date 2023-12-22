// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/main/movable_stack_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> movableItems = [];

  @override
  void initState() {
    addMovableStackItem();
    super.initState();
  }

  void addMovableStackItem() {
    movableItems.add(MovableStackItem(
      key: GlobalKey(),
      onDragEnd: (item) => popUpMovedItem(item),
    ));
  }

  void popUpMovedItem(MovableStackItem item) {
    movableItems.remove(item);
    movableItems.add(item);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
        backgroundColor: palette.backgroundMainScreen,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, right: 20),
                child: IconButton(
                  tooltip: "Add",
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      addMovableStackItem();
                    });
                  },
                ),
              ),
            ),
            Positioned.fill(
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DragTarget(
                  builder: (context, candidateData, rejectedData) {
                    return IconButton(
                      tooltip: "Delete",
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    );
                  },
                  onAcceptWithDetails:
                      (DragTargetDetails<MovableStackItem> details) {
                    movableItems.remove(details.data);
                    setState(() {});
                  },
                ),
              ),
            ),
            Stack(
              children: movableItems,
            ),
          ],
        ));
  }
}
