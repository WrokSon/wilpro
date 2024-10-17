class MyTime {
  int hour;
  int minute;
  int second;

  MyTime({this.hour = 0, this.minute = 0, this.second = 0});

  static MyTime fromValue(int value) {
    int s = value % 60;
    int m = (value ~/ 60) % 60;
    int h = value ~/ 3600;
    return MyTime(hour: h, minute: m, second: s);
  }

  static int toValue(MyTime value) =>
      value.hour * 3600 + value.minute * 60 + value.second;

  int getValue() => hour * 3600 + minute * 60 + second;
}
