import 'dart:async';

import 'package:wilpro/model/enum/format_time_enum.dart';
import 'package:wilpro/model/structure/my_time.dart';
import 'package:wilpro/service/tools.dart';

class MyTimer {
  MyTime countDownDuration = MyTime(minute: 10);
  Duration duration = const Duration();
  Timer? timer;
  Function(MyTime)? update;
  bool isCountdown;
  bool isLetter;
  MyTimer({this.isCountdown = false, this.isLetter = false, this.update});

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void replay() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void setTimer({MyTime? limit}) {
    isCountdown = false;
    if (limit != null){
      isCountdown = true;
      countDownDuration = limit;
    }
    reset();
  }

  void reset() {
    if (isCountdown) {
      duration = Duration(
        hours: countDownDuration.hour,
        minutes: countDownDuration.minute,
        seconds: countDownDuration.second,
      );
    } else {
      duration = const Duration();
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    final seconds = duration.inSeconds + addSeconds;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      duration = Duration(seconds: seconds);
    }
    if (update != null) update!(MyTime.fromValue(seconds));
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    timer?.cancel();
  }

  int getValue() => duration.inSeconds;

  String getText() {
    final time = MyTime(
        hour: duration.inHours,
        minute: duration.inMinutes.remainder(60),
        second: duration.inSeconds.remainder(60));
    return Tools.timeString(time,
        enLettre: isLetter, format: FormatTimeEnum.hhmmss);
  }
}
