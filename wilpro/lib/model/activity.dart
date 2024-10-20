import 'package:wilpro/model/quantity.dart';

class Activity {
  final String id;
  String title;
  List<Quantity> tasks;

  Activity({required this.id, required this.title, required this.tasks});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

}
