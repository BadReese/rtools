import 'dart:convert';

class CommonUtils {
  static const int PAGE_SIZE = 10;
  static const String PAYMENT_WECHAT = "WeChat";
  static const String PAYMENT_ALIPAY = "AliPay";

  // todo 改为动态类型
  static Map<String, dynamic> toMap(String metaData) {
    return json.decode(metaData);
  }

  // todo 改为动态类型
  static String toStr(Map<String, dynamic> map) {
    return json.encode(map);
  }

  static String toJson(List<String> strList) {
    try {
      return json.encode(strList);
    } catch (e) {
      print(e);
      return "";
    }
  }

  static List<String> fromJson(String str) {
    try {
      return List<String>.from(json.decode(str));
    } catch (e) {
      print(e);
      return [];
    }
  }

  static String getFakeCount(int count) {
    count = 8 * count;
    if (count > 10000) {
      return (count ~/ 10000).toInt().toString() + "万";
    }
    return count.toString();
  }

  static String formatCount(int count) {
    if (count > 10000) {
      return (count ~/ 10000).toInt().toString() + "W";
    }
    return count.toString();
  }
}
