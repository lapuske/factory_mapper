import '/collection/character.dart';
import '/collection/item.dart';

class Characters {
  static final factories = {
    'Alice': () => Alice(),
    'Bob': () => Bob(),
    'Charlie': () => Charlie(),
  };
}

class Items {
  static final factories = {
    'MilkItem': (int count) => MilkItem(count),
    'SwordItem': (int count) => SwordItem(count),
    'AppleItem': (int count) => AppleItem(count),
    'AnimeShirtItem': (int count) => AnimeShirtItem(count),
  };
}

