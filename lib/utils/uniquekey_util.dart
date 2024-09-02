// 6
int uniquKey() {
  DateTime now = DateTime.now();
  String id = now.year.toString() +
      now.month.toString() +
      now.day.toString() +
      now.hour.toString() +
      now.minute.toString() +
      now.second.toString() +
      now.millisecond.toString() +
      now.microsecond.toString();
  return int.parse(id);
}
