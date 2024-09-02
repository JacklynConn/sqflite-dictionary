// 1

const String databaseName = "db_dictionary";
const int databaseVersion = 1;
const String tableName = "tbl_word";
const String columnId = "id";
const String columnEnglish = "english";
const String columnKhmer = "khmer";

class WordModel {
  int id;
  String english;
  String khmer;
  WordModel(
      {this.id = 0, this.english = "no english", this.khmer = "no khmer"});
  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map[columnId],
      english: map[columnEnglish],
      khmer: map[columnKhmer],
    );
  }
  Map<String, dynamic> get toMap => {
        columnId: id,
        columnEnglish: english,
        columnKhmer: khmer,
      };
}
