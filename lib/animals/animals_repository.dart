import 'package:baby_animals_app/animals/animals.dart';

class AnimalsRepository {
  final List<AnimalType> availableAnimalTypes = [];

  AnimalsRepository() {
    availableAnimalTypes.add(
      AnimalType.cat,
    );
    availableAnimalTypes.add(
      AnimalType.cow,
    );
    availableAnimalTypes.add(
      AnimalType.horse,
    );
    availableAnimalTypes.add(
      AnimalType.pig,
    );
    availableAnimalTypes.add(
      AnimalType.wolf,
    );
    availableAnimalTypes.add(
      AnimalType.dog,
    );
  }
}
