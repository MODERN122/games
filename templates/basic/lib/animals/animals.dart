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
  }) {
    image = "$_baseImageUrl${type.name}.svg";
    soundName = "$_baseSoundNameUrl${type.name}.wav";
    soundOfAnimal = "$_baseSoundOfAnimalUrl${type.name}.wav";
    backGroundColor = RandomColor().randomColor();
  }

  final AnimalType type;
  late String image;
  late Color backGroundColor;
  late String soundName;
  late String soundOfAnimal;
  final String _baseImageUrl = "assets/images/animals/";
  final String _baseSoundOfAnimalUrl = "music/animals/sounds/";
  final String _baseSoundNameUrl = "music/animals/names/ru/";
}
