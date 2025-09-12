
## Features 
Generate 'ThemeExtension' files

This package makes it easier to write style files by generating code.

## Getting started

You can add the line to the `pubspec.yaml` file:
``theme_extension_gen: ^1.0.0``
Or register it in the console: 
```flutter pub add theme_extension_gen```
Generation is carried out by means of annotations.

## Usage
You need to add the annotation `@ThemeExtensionGen()` above the class, as well as the `part 'theme_colors.g.dart';`:
'''part 'theme_colors.g.dart';
@ThemeExtensionGen()
class ColorsExtension {
  final Color background; //Стандартный задний фон
  final Color appBarBackground; //Задний фон appbar
  final Color appBarButtonIcon;

  final Color primaryButtonBackground; //Задний фон стандартной кнопки
  final Color
      primaryButtonOverlay; //Цвет наложения при нажатии на стандартную кнопку
  final Color disabledPrimaryButtonBackground;

  final Color invertedPrimaryButtonBackground;
  final Color invertedPrimaryButtonOverlay;
  final Color invertedDisabledPrimaryButtonBackground;

  ColorsExtension({
    required this.background,
    required this.appBarBackground,
    required this.primaryButtonBackground,
    required this.primaryButtonOverlay,
    required this.loader,
    required this.bottomBarIconUnselected,
    required this.bottomBarIconSelected,
    required this.disabledPrimaryButtonBackground,
  });
  static ThemeColorsExtension get defaultColors => ThemeColorsExtension(
        background: const Color.fromRGBO(240, 240, 240, 1),
        appBarBackground: const Color.fromRGBO(255, 255, 255, 1),
        primaryButtonBackground: const Color.fromRGBO(20, 142, 255, 1),
        loader: const Color.fromRGBO(20, 142, 255, 1),
        primaryButtonOverlay: Colors.white,
        bottomBarIconUnselected: const Color.fromRGBO(183, 183, 183, 1),
        bottomBarIconSelected: const Color.fromRGBO(20, 142, 255, 1),
        disabledPrimaryButtonBackground: const Color.fromRGBO(210, 210, 210, 1),);
}'''
Then call `dart run build_runner build` from a terminal and a file with styles will be generated.

## Additional information

I'll probably add an example to the github repository.
