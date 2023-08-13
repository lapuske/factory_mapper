`factory_mapper` is a package generating `Map`s of elements annotated with `FactoryElement` annotation.




## Getting started

To start, annotate the classes with `FactoryElement` and run `build_runner` to build the output. It generates the `collection.g.dart` file at the root of your `lib/` directory.




## Usage

Let's say we have the following collection:
```dart
import 'package:factory_mapper/factory_mapper.dart';

import '/model/character.dart';
import '/model/item.dart';

@FactoryElement('Items')
class MilkItem extends Item {
  const MilkItem(super.count);
}

@FactoryElement('Characters')
class Alice extends Character {}

@FactoryElement('Characters')
class Bob extends Character {}
```

Running `build_runner` with the provided collection generates the following `collection.g.dart`:

```dart
import '/collection/character.dart';
import '/collection/item.dart';

class Characters {
  static final factories = {
    'Alice': () => Alice(),
    'Bob': () => Bob(),
  };
}

class Items {
  static final factories = {
    'MilkItem': (int count) => MilkItem(count),
  };
}
```




## Use cases

This packages was intended to be used to create single `Map` containing factories of items, characters, etc, placed throughout your project.

This might be useful when persisting your items, as you may write just the `runtimeType` to your storage (and optionally the parameters alongside your objects) and then use the generated collection and its factory to retrieve it.

Example of usage with [`hive`]:
```dart
import 'package:hive_flutter/hive_flutter.dart';

import '/collection.g.dart';
import '/model/item.dart';

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final runtimeType = reader.read() as String;
    final count = reader.read() as int;
    final factory = Items.factories[runtimeType];

    if (factory == null) {
      Log.print('[$runtimeType] Cannot find `Item` with id: $runtimeType');
      return ImpossibleItem(count);
    }

    return factory!(count) as Item;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer.write(obj.runtimeType.toString());
    writer.write(obj.count);
  }
}
```



[`hive`]: https://pub.dev/packages/hive
