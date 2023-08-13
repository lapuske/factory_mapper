import 'package:factory_mapper/factory_mapper.dart';

import '/model/character.dart';

@FactoryElement('Characters')
class Alice extends Character {
  const Alice();
}

@FactoryElement('Characters')
class Bob extends Character {}

@FactoryElement('Characters')
class Charlie extends Character {}
