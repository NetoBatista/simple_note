import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/core/model/note_motel.dart';
import 'package:simple_note/core/repository/note_repository.dart';
import 'package:simple_note/core/util/context_util.dart';
import 'package:simple_note/core/util/navigation_util.dart';
import 'package:simple_note/features/home_note/home_note_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> onTapCreate() async {
    NavigationUtil.pushNamed(
      '/note',
      arguments: NoteModel(
        id: 0,
        title: '',
        content: '',
        date: DateTime.now().toUtc(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var noteRepository = ContextUtil.watch<NoteRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('notes'.i18n()),
        actions: [
          IconButton(
            onPressed: noteRepository.onChangeSort,
            icon: const Icon(Icons.sort_outlined),
          ),
          IconButton(
            onPressed: onTapCreate,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              onChanged: noteRepository.onChangeFilterNote,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                hintText: "search_notes".i18n(),
                prefixIcon: Icon(
                  Icons.search_outlined,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: noteRepository.notes.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(padding: EdgeInsets.only(bottom: 8));
                },
                itemBuilder: (BuildContext context, int index) {
                  var note = noteRepository.notes.elementAt(index);
                  return HomeNoteComponent(note);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
