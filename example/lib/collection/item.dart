import 'package:collection_gen/collection_gen.dart';

import '/model/item.dart';

@CollectionElement('Items')
class MilkItem extends Item {
  const MilkItem(super.count);
}

@CollectionElement('Items')
class SwordItem extends Item {
  const SwordItem(super.count);
}

@CollectionElement('Items')
class AppleItem extends Item {
  const AppleItem(super.count);
}

@CollectionElement('Items')
class AnimeShirtItem extends Item {
  const AnimeShirtItem(super.count);
}
