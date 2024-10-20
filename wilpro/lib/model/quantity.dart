class Quantity {
  final String id; // pour l'historique
  int value;
  final String idTask;
  Quantity({required this.id, required this.value, required this.idTask});

  static Quantity fromJson(Map<String, dynamic> json) {
    return Quantity(
      id: json['id'],
      value: json['value'],
      idTask: json['idTask']
    );
  }

}
