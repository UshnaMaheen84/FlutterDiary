class NotesModel {

  static const tblNote = 'Note';
  static const colId = 'id';
  static const colNote = 'note';
  String id, note;

  NotesModel({this.note, this.id});

  NotesModel.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    note = map[colNote];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colNote: note};
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
