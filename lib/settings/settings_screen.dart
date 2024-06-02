// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
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
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                AppLocalizations.of(context).soundFx,
                Icon(
                  soundsOn ? Icons.graphic_eq : Icons.volume_off,
                  size: 40,
                ),
                onSelected: () => settings.toggleSoundsOn(),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settings.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                AppLocalizations.of(context).music,
                Icon(
                  musicOn ? Icons.music_note : Icons.music_off,
                  size: 40,
                ),
                onSelected: () => settings.toggleMusicOn(),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settings.languageEn,
              builder: (context, languageEn, child) => _SettingsLine(
                AppLocalizations.of(context).language,
                Image.asset(
                  "assets/images/flags/${languageEn ? "en" : "ru"}.png",
                  semanticLabel: AppLocalizations.of(context).language,
                  height: 40,
                ),
                onSelected: () => settings.toggleLanguageEn(),
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
