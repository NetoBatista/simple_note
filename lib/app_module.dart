import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_note/features/home_screen/home_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // i.addSingleton<IUserService>(UserService.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
