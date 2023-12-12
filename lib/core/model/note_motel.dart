class NoteModel {
  int id;
  String title;
  String content;
  DateTime date;
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  NoteModel clone() {
    var map = toMap();
    map.addAll({'id': id});
    return NoteModel.fromMap(map);
  }
}
