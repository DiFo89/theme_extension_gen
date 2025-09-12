import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import '../annotations.dart';

class ThemeExtensionGenGenerator
    extends GeneratorForAnnotation<ThemeExtensionGen> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Annotation can only be applied on classes',
        element: element,
      );
    }
    final className = element.name!;
    final fields = _getClassFields(element);
    return _generateClass(className, fields);
  }

  Map<String, dynamic> _getClassFields(ClassElement element) {
    final Map<String, dynamic> result = {};
    for (final field in element.fields) {
      if (!_isValidField(field)) {
        continue;
      }
      result[field.name!] = field.type.getDisplayString();
    }
    return result;
  }

  bool _isValidField(FieldElement field) {
    if (field.isSynthetic) return false;
    if (field.isStatic) return false;
    if (field.getter != null && field.getter!.isAbstract) return false;
    if (field.setter != null && field.setter!.isAbstract) return false;
    return true;
  }

  String _generateClass(String className, Map<String, dynamic> fields) {
    final buffer = StringBuffer();
    final String newClassName = "Theme$className";

    buffer.writeln(
      "class $newClassName extends ThemeExtension<$newClassName> {",
    );
    //Поля
    for (MapEntry<String, dynamic> field in fields.entries) {
      buffer.writeln("final ${field.value} ${field.key};");
    }

    //Конструктор
    buffer.writeln();
    buffer.writeln("$newClassName({");
    for (MapEntry<String, dynamic> field in fields.entries) {
      buffer.writeln("required this.${field.key},");
    }
    buffer.writeln("});");

    //Метод copyWith
    buffer.writeln();
    buffer.writeln("@override");
    buffer.writeln("ThemeExtension<$newClassName> copyWith({");

    String getNewFieldName(String name) {
      return "new${name[0].toUpperCase()}${name.substring(1)}";
    }

    for (MapEntry<String, dynamic> field in fields.entries) {
      final newFieldName = getNewFieldName(field.key);
      buffer.writeln("${field.value}? $newFieldName,");
    }
    buffer.writeln("}) {");
    buffer.writeln("return $newClassName (");
    for (MapEntry<String, dynamic> field in fields.entries) {
      buffer.writeln(
        "${field.key}: ${getNewFieldName(field.key)} ?? ${field.key},",
      );
    }
    buffer.writeln(");");
    buffer.writeln("}");

    //Метод lerp

    buffer.writeln();
    buffer.writeln("@override");
    buffer.writeln(
      "ThemeExtension<$newClassName> lerp(ThemeExtension<$newClassName> other, double t) {",
    );
    buffer.writeln("if (other is! $newClassName) {");
    buffer.writeln("return this;");
    buffer.writeln("}");
    buffer.writeln("return $newClassName(");
    for (MapEntry<String, dynamic> field in fields.entries) {
      buffer.writeln(
        "${field.key}: ${field.value}.lerp(${field.key}, other.${field.key}, t)!,",
      );
    }
    buffer.writeln(");");
    buffer.writeln("}");

    buffer.writeln("}"); //Закрывает класс
    return buffer.toString();
  }
}
