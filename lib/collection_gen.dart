/// Generates [Map]s of [CollectionElement]s.
library;

import 'package:build/build.dart';

import 'src/builder.dart';

export 'src/annotation.dart';

Builder collectionBuilder(BuilderOptions options) {
  return CollectionBuilder();
}
