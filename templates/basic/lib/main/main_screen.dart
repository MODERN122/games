// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/main/movable_stack_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<MovableStackItem> movableItems = [];

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
    setState(() {
      if (movableItems.remove(item)) {
        movableItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
        backgroundColor: palette.backgroundMainScreen,
        body: Stack(
          children: [
            Stack(
              children: movableItems,
            ),
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
                child: DragTarget<MovableStackItem>(
                  builder: (context, candidateData, rejectedData) {
                    return IconButton(
                      tooltip: "Delete",
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          if (movableItems.isNotEmpty) {
                            movableItems.remove(movableItems.last);
                          }
                        });
                      },
                    );
                  },
                  onAcceptWithDetails:
                      (DragTargetDetails<MovableStackItem> details) {
                    setState(() {
                      movableItems.remove(details.data);
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
