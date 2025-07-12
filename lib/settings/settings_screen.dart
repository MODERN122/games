// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:baby_animals_app/l10n/app_localizations.dart';
import 'package:baby_animals_app/l10n/languages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreen(
        squarishMainArea: ListView(
          children: [
            _gap,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).settings,
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ),
            ),
            _gap,
            ValueListenableBuilder<bool>(
              valueListenable: settingsController.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                AppLocalizations.of(context).soundFx,
                Icon(
                  soundsOn ? Icons.graphic_eq : Icons.volume_off,
                  size: 40,
                ),
                onSelected: () => settingsController.toggleSoundsOn(),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settingsController.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                AppLocalizations.of(context).music,
                Icon(
                  musicOn ? Icons.music_note : Icons.music_off,
                  size: 40,
                ),
                onSelected: () => settingsController.toggleMusicOn(),
              ),
            ),
            ValueListenableBuilder<Language>(
              valueListenable: settingsController.language,
              builder: (context, language, child) => _SettingsLine(
                AppLocalizations.of(context).language,
                Image.asset(
                  "assets/images/flags/${language.name}.png",
                  semanticLabel: AppLocalizations.of(context).language,
                  height: 40,
                ),
                onSelected: () => settingsController.toggleLanguage(),
              ),
            ),
            _gap,
          ],
        ),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).back),
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: InkResponse(
        highlightShape: BoxShape.rectangle,
        onTap: onSelected,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
