import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContextUtil {
  static T watch<T extends Object>(
    BuildContext context, {
    dynamic Function(T)? onSelect,
  }) {
    return context.watch<T>(onSelect);
  }
}
