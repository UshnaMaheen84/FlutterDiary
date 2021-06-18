import 'dart:math';

class DiaryModel {

  static const tblDiary = 'Diary';
  static const colId = 'id';
  static const colSubject = 'subject';
  static const colEntry = 'entry';
  static const colDate = 'date';

  String date, subject, entry, id;

  DiaryModel(this.date, this.subject, this.entry, this.id);

  DiaryModel.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    subject = map[colSubject];
    entry = map[colEntry];
    date = map[colDate];

  }
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colSubject: subject, colEntry: entry, colDate: date};
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
