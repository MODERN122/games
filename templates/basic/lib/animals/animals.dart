import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

enum AnimalType {
  horse,
  cow,
  dog,
  cat,
  pig,
  wolf,
}

class Animal {
  Animal({
    required this.type,
    required this.context,
  }) {
    Locale locale = Localizations.localeOf(context);
    String localePath = locale.languageCode.toLowerCase();

    if (localePath == 'und') {
      localePath = 'en';
    }

    image = "$_baseImageUrl${type.name}.svg";
    soundName = "$_baseSoundNameUrl$localePath/${type.name}.wav";
    soundOfAnimal = "$_baseSoundOfAnimalUrl${type.name}.mp3";
    backGroundColor = RandomColor().randomColor();
  }

  final AnimalType type;
  final BuildContext context;
  late String image;
  late Color backGroundColor;
  late String soundName;
  late String soundOfAnimal;
  final String _baseImageUrl = "assets/images/animals/";
  final String _baseSoundOfAnimalUrl = "music/animals/sounds/";
  final String _baseSoundNameUrl = "music/animals/names/";
}
