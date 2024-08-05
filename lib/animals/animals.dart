import 'package:baby_animals_app/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

enum AnimalType {
  horse,
  cow,
  dog,
  cat,
  pig,
  wolf,
  chicken,
  sheep,
}

class Animal {
  Animal({
    required this.type,
    required this.context,
  }) {
    final settings = Provider.of<SettingsController>(context, listen: false);
    image = "$_baseImageUrl${type.name}.svg";
    soundName =
        "$_baseSoundNameUrl${settings.language.value.name}/${type.name}.wav";
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
