import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_extension_gen/src/generator.dart';

Builder themeExtensionGenerator(BuilderOptions options) {
  return PartBuilder([ThemeExtensionGenGenerator()], '.theme.g.dart');
}
