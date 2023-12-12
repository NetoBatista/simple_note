import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/core/model/note_motel.dart';
import 'package:simple_note/core/repository/note_repository.dart';
import 'package:simple_note/core/util/context_util.dart';
import 'package:simple_note/core/util/navigation_util.dart';

class NotePage extends StatefulWidget {
  final NoteModel note;
  const NotePage(this.note, {super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    var noteRepository = ContextUtil.watch<NoteRepository>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var titleEmpty = widget.note.title.trim().isEmpty;
          var contentEmpty = widget.note.content.trim().isEmpty;
          if (titleEmpty && contentEmpty) {
            NavigationUtil.pop();
            return;
          }
          if (widget.note.id != 0) {
            await noteRepository.update(widget.note);
          } else {
            await noteRepository.insert(widget.note);
          }
          NavigationUtil.pop();
        },
        child: const Icon(Icons.save_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                const IconButton(
                  onPressed: NavigationUtil.pop,
                  icon: Icon(Icons.arrow_back),
                ),
                Text(
                  'notes'.i18n(),
                  style: const TextStyle(fontSize: 24),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    var text = "${widget.note.title}\n\n${widget.note.content}";
                    await Clipboard.setData(ClipboardData(text: text.trim()));
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'successfully_copied'.i18n(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy_outlined),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: widget.note.title,
                      onChanged: (value) {
                        widget.note.title = value;
                      },
                      maxLines: null,
                      style: const TextStyle(fontSize: 32),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'title'.i18n(),
                      ),
                    ),
                    const Divider(thickness: 2),
                    TextFormField(
                      initialValue: widget.note.content,
                      onChanged: (value) {
                        widget.note.content = value;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'content'.i18n(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
