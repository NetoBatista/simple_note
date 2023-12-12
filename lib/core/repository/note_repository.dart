import 'package:flutter/material.dart';
import 'package:simple_note/core/database/local_database.dart';
import 'package:simple_note/core/model/note_motel.dart';

class NoteRepository extends ChangeNotifier {
  NoteRepository() {
    _initialize();
  }

  final _table = "note";
  var typeSort = "desc";
  var filterNote = "";

  List<NoteModel> _notes = [];

  List<NoteModel> get notes {
    var response = _notes.sublist(0);
    if (typeSort == "desc") {
      response.sort((a, b) => b.date.compareTo(a.date));
    } else {
      response.sort((a, b) => a.date.compareTo(b.date));
    }
    if (filterNote.isNotEmpty) {
      return response
          .where(
            (x) => x.title.toLowerCase().contains(filterNote.toLowerCase()),
          )
          .toList();
    }
    return response;
  }

  void onChangeSort() {
    typeSort = typeSort == "desc" ? "asc" : "desc";
    notifyListeners();
  }

  void onChangeFilterNote(String value) {
    filterNote = value;
    notifyListeners();
  }

  Future<void> _initialize() async {
    var database = await LocalDatabase.instance.database;
    var response = await database.query(_table);
    if (response.isNotEmpty) {
      _notes = response.map((e) => NoteModel.fromMap(e)).toList();
    }
    notifyListeners();
  }

  Future<void> insert(NoteModel noteModel) async {
    noteModel.date = DateTime.now().toUtc();
    var database = await LocalDatabase.instance.database;
    var id = await database.insert(_table, noteModel.toMap());
    noteModel.id = id;
    _notes.add(noteModel);
    notifyListeners();
  }

  Future<void> update(NoteModel noteModel) async {
    noteModel.date = DateTime.now().toUtc();
    var database = await LocalDatabase.instance.database;
    await database.update(
      _table,
      noteModel.toMap(),
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
    var index = _notes.indexWhere((element) => element.id == noteModel.id);
    _notes.removeAt(index);
    _notes.insert(index, noteModel);
    notifyListeners();
  }

  Future<void> delete(NoteModel noteModel) async {
    var database = await LocalDatabase.instance.database;
    await database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
    var index = _notes.indexWhere((element) => element.id == noteModel.id);
    _notes.removeAt(index);
    notifyListeners();
  }
}
