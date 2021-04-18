

class TextUtils {
  static String trimIfMoreThan(String target, int maxLength, {String trimAfter = "..."}) {
    if (target != null && target.length > maxLength) {
      return target.substring(0, maxLength) + trimAfter;
    } else {
      return target;
    }
  }
}