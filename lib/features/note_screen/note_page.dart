import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:simple_note/core/model/note_motel.dart';
import 'package:simple_note/core/repository/note_repository.dart';
import 'package:simple_note/core/util/context_util.dart';
import 'package:simple_note/core/util/navigation_util.dart';
import 'package:simple_note/features/alert_delete_note/alert_delete_note.dart';

class NotePage extends StatefulWidget {
  final NoteModel note;
  const NotePage(this.note, {super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late NoteRepository repository;
  late String originalTitle = '';
  late String originalContent = '';
  @override
  void initState() {
    originalTitle = widget.note.title;
    originalContent = widget.note.content;
    super.initState();
  }

  @override
  void dispose() {
    onTapSave();
    super.dispose();
  }

  Future<void> onTapRemove() async {
    var deleteItem = await AlertDeleteNote(context).showAlertDelete();
    if (deleteItem) {
      await repository.delete(widget.note);
      NavigationUtil.pop();
    }
  }

  Future<void> onTapSave() async {
    var titleEmpty = widget.note.title.trim().isEmpty;
    var contentEmpty = widget.note.content.trim().isEmpty;
    if (titleEmpty && contentEmpty) {
      return;
    }
    if (originalTitle == widget.note.title &&
        originalContent == widget.note.content) {
      return;
    }
    if (widget.note.id != 0) {
      await repository.update(widget.note);
    } else {
      await repository.insert(widget.note);
    }
  }

  Future<void> onTapCopy() async {
    var text = "${widget.note.title}\n\n${widget.note.content}";
    await Clipboard.setData(ClipboardData(text: text.trim()));
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'successfully_copied'.i18n(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    repository = ContextUtil.watch<NoteRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notes'.i18n(),
          style: const TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              onTapSave();
              NavigationUtil.pop();
            },
            icon: const Icon(Icons.save_outlined),
          ),
          IconButton(
            onPressed: onTapCopy,
            icon: const Icon(Icons.copy_outlined),
          ),
          Visibility(
            visible: widget.note.id != 0,
            child: IconButton(
              onPressed: onTapRemove,
              icon: const Icon(Icons.delete_outline),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
            Expanded(
              child: TextFormField(
                initialValue: widget.note.content,
                onChanged: (value) {
                  widget.note.content = value;
                },
                minLines: null,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'content'.i18n(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
