// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Baby Animals App';

  @override
  String get mainScreenTitle => 'App for my son!';

  @override
  String get add => 'Добавить';

  @override
  String get delete => 'Удалить';

  @override
  String errorAnimalImageNotFound(String animalType) {
    return 'Изображения с типом $animalType не найдено!';
  }

  @override
  String get play => 'Играть';

  @override
  String get settings => 'Настройки';

  @override
  String get musicByMrSmith => 'Автор музыки Mr Smith';

  @override
  String get language => 'Язык';

  @override
  String get music => 'Музыка';

  @override
  String get player => 'Игрок';

  @override
  String get soundFx => 'Звуки';

  @override
  String get back => 'Назад';

  @override
  String get close => 'Закрыть';

  @override
  String get changeName => 'Изменить имя';

  @override
  String get lock => 'Заблокировать';

  @override
  String get unlock => 'Разблокировать';
}
