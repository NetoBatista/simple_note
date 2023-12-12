import 'package:flutter_modular/flutter_modular.dart';

class NavigationUtil {
  static void pop<T extends Object?>([T? result]) {
    return Modular.to.pop(result);
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return Modular.to.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
