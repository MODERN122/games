// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:basic/animals/animals.dart';
import 'package:basic/animals/animals_repository.dart';
import 'package:basic/main/movable_stack_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';
import 'package:flutter_lock_task/flutter_lock_task.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<MovableStackItem> movableItems = [];
  bool isLocked = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && Platform.isAndroid) {
      timer =
          Timer.periodic(Duration(seconds: 1), (Timer t) => checkIsLocked());
    }
  }

  int indexCount = 0;

  void addMovableStackItem(BuildContext context) {
    final animalsRepository = context.read<AnimalsRepository>();
    // int randomIndex =
    //     Random().nextInt(animalsRepository.availableAnimalTypes.length);
    int index = indexCount++ % animalsRepository.availableAnimalTypes.length;
    movableItems.add(MovableStackItem(
      animal: Animal(
          type: animalsRepository.availableAnimalTypes[index],
          context: context),
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
  void dispose() {
    timer?.cancel();
    //TODO dispose music animals
    super.dispose();
  }

  Future checkIsLocked() async {
    await FlutterLockTask().isInLockTaskMode().then(
      (value) {
        if (isLocked != value) {
          setState(() {
            isLocked = value;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return PopScope(
      canPop: !isLocked,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
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
                  tooltip: AppLocalizations.of(context).add,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      addMovableStackItem(context);
                    });
                  },
                ),
              ),
            ),
            Positioned.fill(
              bottom: 20,
              left: 20,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Icon(
                    (isLocked) ? Icons.lock_open : Icons.lock,
                  ),
                  onPressed: () async {
                    if (!kIsWeb && Platform.isAndroid) {
                      if (isLocked) {
                        FlutterLockTask().stopLockTask().then((value) {
                          if (kDebugMode) {
                            print("stopLockTask: $value");
                          }
                          setState(() {
                            timer?.cancel();
                          });
                          // if (value) {
                          //   checkIsLocked();
                          // }
                        });
                      } else {
                        FlutterLockTask().startLockTask().then((value) {
                          if (kDebugMode) {
                            print("startLockTask: $value");
                          }
                          setState(() {
                            timer = Timer.periodic(Duration(seconds: 1),
                                (Timer t) => checkIsLocked());
                          });
                          // if (value) {
                          //   checkIsLocked();
                          // }
                        });
                      }
                    }
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
                      tooltip: AppLocalizations.of(context).delete,
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
            Positioned.fill(
              bottom: -20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DragTarget<MovableStackItem>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      height: 75,
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
        ),
      ),
    );
  }
}
