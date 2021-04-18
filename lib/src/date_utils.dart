import 'package:intl/intl.dart';

class DateUtils {
  // 服务器的时间用秒 带小数 精确到后3位
  // 本地用毫秒

  static const weekdayString = ["无", "一", "二", "三", "四", "五", "六", "日"];

  // 将时间戳格式化为本地时间
  static String friendly(double timestamp, {String defaultS = "无法解析"}) {
    if (timestamp == null || timestamp == 0) {
      return defaultS;
    }
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    return date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();
  }

  static String friendlyTM(double timestamp) {
    if (timestamp == null || timestamp == 0) {
      return "无法解析";
    }
    var nowSecond = DateTime.now().millisecondsSinceEpoch / 1000;
    double secondsDif = nowSecond - timestamp;
    if (secondsDif < 300) {
      return "刚刚";
    } else if (secondsDif < 3600) {
      return (secondsDif ~/ 60).toString() + "分钟前";
    } else {
      var hours = secondsDif ~/ 3600;
      if (hours < 24) {
        return hours.toString() + "小时前";
      }
    }
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    return date.month.toString() +
        "-" +
        date.day.toString() +
        " " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  static String dateTimeOrYear(double timestamp, {String defaultS = "未知时间"}) {
    if (timestamp == null || timestamp == 0) {
      return defaultS;
    }
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    String formatStr = "yyyy-M-d H:mm";
    if (date.year == DateTime.now().year) {
      formatStr = "M-d H:mm";
    } else {
      formatStr = "yyyy-M-d H:mm";
    }
    return DateFormat(formatStr).format(date);
  }

  // 同天就只显示时间 同月.. 同年..
  static String miniFormat(double timestamp, {String defaultS = "未知时间"}) {
    if (timestamp == null || timestamp == 0) {
      return defaultS;
    }
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    var now = DateTime.now();
    String formatStr;
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      formatStr = "H:mm";
    } else if (date.year == now.year) {
      formatStr = "M-d H:mm";
    } else {
      formatStr = "yyyy-M-d H:mm";
    }
    return DateFormat(formatStr).format(date);
  }

  static String formatTo(double timestamp,
      {String format = "yyyy-M-d H:mm:ss", String defaultS = "无法解析"}) {
    if (timestamp == null || timestamp == 0) {
      return defaultS;
    }
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    return DateFormat(format).format(date);
  }

  // 完整24小时算一天
  static int hours24TillNow(double timestamp) {
    if (timestamp == null) {
      return 0;
    }
    var date = timestampToDateTime(timestamp);
    return DateTime.now().difference(date).inDays;
  }

  static int daysBetween2DateZero(
    double zeroTimestamp1,
    double zeroTimestamp2,
  ) {
    if (zeroTimestamp1 == null || zeroTimestamp2 == null) {
      return 0;
    }
    var date1 = timestampToDateTime(zeroTimestamp1);
    var date2 = timestampToDateTime(zeroTimestamp2);
    if (zeroTimestamp1 > zeroTimestamp2) {
      return date1.difference(date2).inDays;
    } else {
      return date2.difference(date1).inDays;
    }
  }

  static double secondsTillNow(double timestamp) {
    if (timestamp == null) {
      return 0;
    }
    var date = timestampToDateTime(timestamp);
    return DateTime.now().difference(date).inMilliseconds / 1000;
  }

  static DateTime timestampToDateTime(double timestamp) {
    return DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
  }

  static double getZeroTimestamp(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day)
            .millisecondsSinceEpoch
            .toDouble() /
        1000;
  }

  static double toZeroTimestamp(double timestamp) {
    var dateTime = timestampToDateTime(timestamp);
    return DateTime(dateTime.year, dateTime.month, dateTime.day)
            .millisecondsSinceEpoch
            .toDouble() /
        1000;
  }

  static double todayGSZeroTimestamp() {
    return getGSZeroTimestamp(DateTime.now().millisecondsSinceEpoch / 1000);
  }

  static double firstDayTimestampOfMonth(double timestampOfAnydayInMonth,
      {bool isDateZero = false}) {
    var date = timestampToDateTime(timestampOfAnydayInMonth).toUtc();
    DateTime targetDateTime;
    if (isDateZero) {
      targetDateTime = DateTime.utc(date.year, date.month, 1, 0, 0, 0, 0, 0);
    } else {
      targetDateTime = DateTime.utc(date.year, date.month, 1, date.hour,
          date.minute, date.second, date.millisecond, date.microsecond);
    }
    return targetDateTime.toLocal().millisecondsSinceEpoch / 1000;
  }

  static double todayZeroTimestamp() {
    return getZeroTimestamp(DateTime.now());
  }

  static double now() {
    return DateTime.now().millisecondsSinceEpoch / 1000;
  }

  static bool isToday(double timestamp) {
    if (timestamp == null || timestamp <= 0) {
      return false;
    }
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    var today = DateTime.now();
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return true;
    }
    return false;
  }

  static int secondsOfTodayTillNow() {
    var datetime = DateTime.now();
    return datetime.hour * 3600 + datetime.minute * 60 + datetime.second;
  }

  static DateTime addDay(DateTime target, int add) {
    var otherDay = target.millisecondsSinceEpoch + (add * 86400000);
    return DateTime.fromMillisecondsSinceEpoch(otherDay);
  }

  static double getGSZeroTimestampByDate(DateTime date) {
    return getGSZeroTimestamp(date.millisecondsSinceEpoch / 1000);
  }

  static double getGSZeroTimestamp(double timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
    if (date.hour < 3) {
      return getZeroTimestamp(DateTime.fromMillisecondsSinceEpoch(
          ((timestamp - 86400) * 1000).toInt()));
    }
    return getZeroTimestamp(date);
  }
}
