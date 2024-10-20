class Task {
  final String id;
  String title;
  bool withTimer;

  Task({
    required this.id,
    required this.title,
    required this.withTimer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'withTimer': withTimer ? 1 : 0, // Convertit le booléen en entier
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      withTimer: json['withTimer'] == 1, // Convertit l'entier en booléen
    );
  }
}
