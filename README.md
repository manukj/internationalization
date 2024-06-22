Sure! Below are the steps written in Markdown format for your `README.md` file:

```markdown
# Internationalization

A Dart package for generating lang_internationalization files from annotated classes. This package helps you manage localization in your Flutter applications by automatically generating localization files based on your annotations.

## Features

- Automatically generate localization files for multiple languages.
- Merge new keys with existing localization files without overwriting existing keys.
- Easy to use annotations for specifying supported locales.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  lang_internationalization: ^1.0.0

dev_dependencies:
  build_runner: ^2.0.0
  source_gen: ^1.0.0
  analyzer: ^5.12.0
```

Then run:

```sh
flutter pub get
```

## Usage

### Step 1: Annotate Your Classes

Use the `@Internationalisation` annotation to specify the locales for your classes:

```dart
import 'package:lang_internationalization/annotations.dart';

part 'string_constant.g.dart';

@LangInternationalization(['en', 'zh'])
class StringConstant {
  static const String hello = 'hello';
  static const String world = 'world';
}
```

### Step 3: Run the Code Generation

Run the following command to generate the localization files:

```sh
dart run build_runner build
```

**Generated localization files will be created in the same directory as your source files, under a `lang` subdirectory with the name of the local u have given in LangInternationalization**


## Example

Here is an example of how to use the generated localization files in your Flutter application:

```dart
import 'package:flutter/material.dart';
import '$directory/lang/en.g.dart';
import '$directory/lang/es.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Internationalization Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(en['hello']),
              Text(es['world']),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature-name`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature/your-feature-name`).
6. Create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [build_runner](https://pub.dev/packages/build_runner)
- [source_gen](https://pub.dev/packages/source_gen)
- [analyzer](https://pub.dev/packages/analyzer)

## Contact

For any questions or suggestions, feel free to open an issue or contact the manu1998kj@gmail.com.
