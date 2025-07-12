// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Baby Animals App';

  @override
  String get mainScreenTitle => 'App for my son!';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String errorAnimalImageNotFound(String animalType) {
    return 'Image with $animalType not found!';
  }

  @override
  String get play => 'Play';

  @override
  String get settings => 'Settings';

  @override
  String get musicByMrSmith => 'Music by Mr Smith';

  @override
  String get language => 'Language';

  @override
  String get music => 'Music';

  @override
  String get player => 'Player';

  @override
  String get soundFx => 'Sound';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get changeName => 'Change name';

  @override
  String get lock => 'Lock';

  @override
  String get unlock => 'Unlock';
}
