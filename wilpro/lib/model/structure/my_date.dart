class MyDate {
  int day;
  int month;
  int year;
  MyDate({this.day = 1, this.month = 1, this.year = 2024});

  String getValue() => "$day-$month-$year";

  static MyDate fromValue(String value) {
    final res = value.split('-').map(int.parse).toList();
    return MyDate(day: res[0], month: res[1], year: res[2]);
  }
}
