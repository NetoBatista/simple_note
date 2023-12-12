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
  @override
  Widget build(BuildContext context) {
    var noteRepository = ContextUtil.watch<NoteRepository>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationUtil.pushNamed(
            '/note',
            arguments: NoteModel(
              id: 0,
              title: '',
              content: '',
              date: DateTime.now().toUtc(),
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'notes'.i18n(),
                  style: const TextStyle(fontSize: 36),
                ),
                IconButton(
                  onPressed: noteRepository.onChangeSort,
                  icon: const Icon(
                    Icons.sort_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              onChanged: noteRepository.onChangeFilterNote,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                hintText: "search_notes".i18n(),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: noteRepository.notes.length,
                itemBuilder: (context, index) {
                  var note = noteRepository.notes.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: HomeNoteComponent(note),
                  );
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
