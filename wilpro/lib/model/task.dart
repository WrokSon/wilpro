class Task {
  String id;
  DateTime? time;
  String title;
  bool withTimer;

  Task({
    required this.id,
    this.time,
    required this.title,
    required this.withTimer,
  });
}
