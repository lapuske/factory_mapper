import 'package:factory_mapper/factory_mapper.dart';

import '/model/item.dart';

@FactoryElement('Items')
class MilkItem extends Item {
  const MilkItem(super.count);
}

@FactoryElement('Items')
class SwordItem extends Item {
  const SwordItem(super.count);
}

@FactoryElement('Items')
class AppleItem extends Item {
  const AppleItem(super.count);
}

@FactoryElement('Items')
class AnimeShirtItem extends Item {
  const AnimeShirtItem(super.count);
}
