// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:baby_animals_app/animals/animals.dart';
import 'package:baby_animals_app/animals/animals_repository.dart';
import 'package:baby_animals_app/main/full_screen_modal.dart';
import 'package:baby_animals_app/main/movable_stack_item.dart';
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
  int indexCount = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && Platform.isAndroid) {
      timer =
          Timer.periodic(Duration(seconds: 1), (Timer t) => checkIsLocked());
    }
    addMovableStackItem(context);
    addMovableStackItem(context, top: 240);
    addMovableStackItem(context, left: 190);
  }

  // this method shows the modal dialog
  void _showModal(BuildContext context) async {
    // show the modal dialog and pass some data to it
    final result = await Navigator.of(context).push(FullScreenModal());
    // ignore: use_build_context_synchronously
    if (result == AppLocalizations.of(context).unlock) {
      FlutterLockTask().stopLockTask().then((value) {
        if (kDebugMode) {
          print("stopLockTask: $value");
        }
        setState(() {
          timer?.cancel();
        });
      });
    }
  }

  void addMovableStackItem(
    BuildContext context, {
    double top = 40,
    double left = 10,
  }) {
    final animalsRepository = context.read<AnimalsRepository>();
    // int randomIndex =
    //     Random().nextInt(animalsRepository.availableAnimalTypes.length);
    int index = indexCount++ % animalsRepository.availableAnimalTypes.length;
    movableItems.add(MovableStackItem(
      top: top,
      left: left,
      animal: Animal(
          type: animalsRepository.availableAnimalTypes[index],
          context: context),
      key: GlobalKey(),
      onDragEnd: (item) => popUpMovedItem(item),
    ));
  }

  void popUpMovedItem(MovableStackItem item) {
    // setState(() {
    //   if (movableItems.remove(item)) {
    //     movableItems.add(item);
    //   }
    // });
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
        extendBodyBehindAppBar: true,
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
                  tooltip: (isLocked)
                      ? AppLocalizations.of(context).unlock
                      : AppLocalizations.of(context).lock,
                  onPressed: () async {
                    if (!kIsWeb && Platform.isAndroid) {
                      if (isLocked) {
                        _showModal(context);
                      } else {
                        FlutterLockTask().startLockTask().then((value) {
                          if (kDebugMode) {
                            print("startLockTask: $value");
                          }
                          setState(() {
                            timer = Timer.periodic(Duration(seconds: 1),
                                (Timer t) => checkIsLocked());
                          });
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
                //Область для удаления обьектов
                //при перетаскивании на кнопку удалить
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
            //Нижняя область для удаления обьектов
            Positioned.fill(
              bottom: -40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DragTarget<MovableStackItem>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      height: 95,
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
