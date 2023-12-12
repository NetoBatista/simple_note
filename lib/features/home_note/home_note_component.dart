import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/core/model/note_motel.dart';
import 'package:simple_note/core/repository/note_repository.dart';
import 'package:simple_note/core/util/context_util.dart';
import 'package:simple_note/core/util/date_util.dart';
import 'package:simple_note/core/util/navigation_util.dart';
import 'package:simple_note/features/alert_delete_note/alert_delete_note.dart';

class HomeNoteComponent extends StatelessWidget {
  final NoteModel noteModel;
  const HomeNoteComponent(this.noteModel, {super.key});

  @override
  Widget build(BuildContext context) {
    var noteRepository = ContextUtil.watch<NoteRepository>(context);

    return Card(
      elevation: 10,
      child: ListTile(
        onTap: () {
          NavigationUtil.pushNamed('note', arguments: noteModel.clone());
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noteModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              noteModel.content,
              style: const TextStyle(fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        subtitle: Text(
          '${"edited".i18n()}: ${DateUtil.getFormattedDate(noteModel.date)}',
          style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade500),
        ),
        trailing: IconButton(
          onPressed: () async {
            var deleteItem = await AlertDeleteNote(context).showAlertDelete();
            if (deleteItem) {
              await noteRepository.delete(noteModel);
            }
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
