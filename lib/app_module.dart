import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_note/core/repository/note_repository.dart';
import 'package:simple_note/features/home_screen/home_page.dart';
import 'package:simple_note/features/note_screen/note_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(NoteRepository.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/note', child: (context) => NotePage(r.args.data));
  }
}
