import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:get_internationalization/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

class InternationalizationBuilder
    extends GeneratorForAnnotation<Internationalization> {
  @override
  Future<FutureOr<String>> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    print('Generating internationalization files...');
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `${element.displayName}`. '
        'It should only be applied to classes.',
        element: element,
      );
    }
    final locales = annotation
        .read('locales')
        .listValue
        .map((e) => e.toStringValue())
        .toList();

    final fields =
        (element).fields.where((field) => field.isStatic && field.isConst);

    _writeToFiles(locales, fields);
    return '';
  }

  Future<void> _writeToFiles(
      List<String?> locales, Iterable<FieldElement> fields) async {
    for (var locale in locales) {
      final fileName = 'lang/$locale.dart';
      final file = File(fileName);

      Map<String, String> existingMap = {};
      if (file.existsSync()) {
        final content = await file.readAsString();
        existingMap = _parseExistingMap(content);
      } else {
        file.createSync(recursive: true);
      }

      final buffer = StringBuffer();
      buffer.writeln('const Map<String, String> $locale = {');
      for (var field in fields) {
        final key = field.name;
        final value = field.computeConstantValue()?.toStringValue();
        if (!existingMap.containsKey(key)) {
          buffer.writeln('  \'$key\': \'$value\',');
        }
      }
      buffer.writeln('};');

      await file.writeAsString(buffer.toString(),
          mode: FileMode.writeOnlyAppend);
    }
  }

  Map<String, String> _parseExistingMap(String content) {
    final map = <String, String>{};
    final regex = RegExp(r"'(\w+)':\s*'([^']*)',");
    for (var match in regex.allMatches(content)) {
      var key = match.group(1);
      var value = match.group(2);
      if (key != null) {
        map[key] = value ?? '';
      }
    }
    return map;
  }
}

Builder internationalizationBuilder(BuilderOptions options) =>
    SharedPartBuilder([InternationalizationBuilder()], 'internationalization');