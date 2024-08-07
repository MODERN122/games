// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:baby_animals_app/l10n/languages.dart';
import 'package:baby_animals_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settingsController =
          Provider.of<SettingsController>(context, listen: false);
      settingsController.language.addListener(() {
        MyApp.setLocale(
            context,
            switch (settingsController.language.value) {
              Language.en => const Locale("en", "US"),
              Language.ru => const Locale("ru", "RU"),
              Language.unknown => const Locale("en", "US"),
            });
      });
      var languageName = AppLocalizations.of(context).localeName;
      var language = Language.values.byName(languageName);
      settingsController.setLanguage(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final audioController = context.watch<AudioController>();
    final settingsController = context.watch<SettingsController>();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: palette.backgroundMain,
        body: ResponsiveScreen(
          squarishMainArea: Center(
            child: Transform.rotate(
              angle: -0.1,
              child: Text(
                AppLocalizations.of(context).appTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 55,
                  height: 1,
                ),
              ),
            ),
          ),
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: () {
                  audioController.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).go('/play');
                },
                child: Text(AppLocalizations.of(context).play),
              ),
              _gap,
              MyButton(
                onPressed: () => GoRouter.of(context).push('/settings'),
                child: Text(AppLocalizations.of(context).settings),
              ),
              _gap,
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ValueListenableBuilder<bool>(
                  valueListenable: settingsController.audioOn,
                  builder: (context, audioOn, child) {
                    return IconButton(
                      onPressed: () => settingsController.toggleAudioOn(),
                      icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                    );
                  },
                ),
              ),
              _gap,
              Text(AppLocalizations.of(context).musicByMrSmith),
              _gap,
            ],
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
