import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/core/model/note_motel.dart';
import 'package:simple_note/core/util/date_util.dart';
import 'package:simple_note/core/util/navigation_util.dart';

class HomeNoteComponent extends StatelessWidget {
  final NoteModel noteModel;
  const HomeNoteComponent(this.noteModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          NavigationUtil.pushNamed('note', arguments: noteModel.clone());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                noteModel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                noteModel.content,
                style: const TextStyle(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                '${"edited".i18n()}: ${DateUtil.getFormattedDate(noteModel.date.toLocal())}',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
