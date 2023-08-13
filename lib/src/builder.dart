import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

Builder factoryBuilder(BuilderOptions options) {
  return FactoryBuilder();
}

class FactoryBuilder implements Builder {
  const FactoryBuilder();

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['collection.g.dart'],
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // final resolver = buildStep.resolver;
    // print();

    final assets = buildStep.findAssets(Glob('**/*.dart'));

    final Map<String, List<AnnotatedElement>> collections = {};
    final List<AssetId> imports = [];

    await for (var asset in assets) {
      if (await buildStep.resolver.isLibrary(asset)) {
        final library = await buildStep.resolver.libraryFor(asset);
        final reader = LibraryReader(library);

        Iterable<AnnotatedElement> annotations =
            reader.annotatedWith(TypeChecker.fromRuntime(FactoryElement));
        if (annotations.isNotEmpty) {
          imports.add(asset);
        }

        for (var a in annotations) {
          final String collection = a.annotation.read('collection').stringValue;
          final List<AnnotatedElement>? list = collections[collection];
          if (list != null) {
            list.add(a);
          } else {
            collections[collection] = [a];
          }
        }
      }
    }

    print('COLLECTIONS: ${collections.keys}');

    if (collections.isEmpty) {
      // Nothing to generate.
      return;
    }

    final StringBuffer buffer = StringBuffer();

    for (var i in imports) {
      buffer.write('import \'${i.path.replaceFirst('lib', '')}\';\n');
    }

    buffer.writeln();

    for (var c in collections.keys) {
      final List<AnnotatedElement> list = collections[c]!;

      buffer.write(
        'class $c {\n'
        '  static final factories = {\n',
      );

      for (var e in list) {
        final StringBuffer code = StringBuffer();
        code.write('\'${e.element.name}\': ');

        final ConstructorElement? ctor =
            (e.element as ClassElement).constructors.firstOrNull;

        if (ctor == null) {
          code.write('() => ${e.element.name}()');
        } else {
          String name = e.element.displayName;
          if (ctor.isConst == true && ctor.parameters.isEmpty) {
            name = 'const $name';
          }

          code.write(
            '(${ctor.parameters.join(',')}) => $name(${ctor.parameters.map((e) => e.name).join(',')})',
          );
        }

        code.write(',\n');
        buffer.write('    ${code.toString()}');
      }

      buffer.write(
        '  };\n'
        '}\n\n',
      );
    }

    final outputId =
        AssetId(buildStep.inputId.package, 'lib/collection.g.dart');
    await buildStep.writeAsString(outputId, buffer.toString());
  }
}
