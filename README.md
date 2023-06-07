`collection_gen` is a package generating `Map`s of elements annotated with `CollectionElement` annotation.

## Getting started

To start, annotate the classes with `CollectionElement` and run `build_runner` to build the output. It generates the `collection.g.dart` file at the root of your `lib/` directory.

## Usage

Let's say we have the following collection:
```dart
import 'package:collection_gen/collection_gen.dart';

import '/model/character.dart';
import '/model/item.dart';

@CollectionElement('Items')
class MilkItem extends Item {
  const MilkItem(super.count);
}

@CollectionElement('Characters')
class Alice extends Character {}

@CollectionElement('Characters')
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
