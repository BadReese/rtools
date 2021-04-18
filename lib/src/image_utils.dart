import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static const String DEFAULT_TWEET_PATH = "assets/default_tweet_photo.png";

  static const String BCE_STYLE = "?x-bce-process=style";
  static const String THUMB_URL_FUNC = "?x-bce-process=image/resize,m_lfit";
  static const String IMAGE_INFO_URL = "?imageInfo/";

  static const double ORIGINAL_SIZE = 800; // 这个尺寸基本弃用
  static const double LARGE_SIZE = 1500; // 比较合适的大图尺寸
  static const double THUMB_MAX_SIZE = 400;
  static const double THUMB_FACE_MAX_SIZE = 400;

  // cos

  static String getThumbUrl(String url,
      {double width: THUMB_MAX_SIZE, double height: THUMB_MAX_SIZE}) {
    if (url != null &&
        !url.contains(BCE_STYLE) &&
        (width != null || height != null)) {
      var original = getOriginalUrl(url);
      var thumbUrl = original + THUMB_URL_FUNC;
      if (width != null && width > 0) {
        thumbUrl += ",w_" + (width.toInt()).toString();
      }
      if (height != null && height > 0) {
        thumbUrl += ",h_" + (height.toInt()).toString();
      }
      return thumbUrl;
    } else {
      return url;
    }
  }

  static String getThumbFaceUrl(String url) {
    if (url != null) {
      var original = getOriginalUrl(url);
      return original +
          THUMB_URL_FUNC +
          ",w_" +
          THUMB_FACE_MAX_SIZE.toString() +
          ",h_" +
          THUMB_FACE_MAX_SIZE.toString();
    } else {
      return url;
    }
  }

  static String getLargeUrl(String url) {
    return getThumbUrl(url, width: LARGE_SIZE, height: null);
  }

  static String getOriginalUrl(String url) {
    String prefix;
    if (url != null && url.contains(THUMB_URL_FUNC)) {
      prefix = THUMB_URL_FUNC;
    } else if (url != null && url.contains(IMAGE_INFO_URL)) {
      prefix = IMAGE_INFO_URL;
    } else {
      return url;
    }
    var splitStr = url.split(prefix);
    if (splitStr.length > 0) {
      return splitStr[0];
    } else {
      return url;
    }
  }

  static Future<String> getDocumentDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> writeToLocalPath(
      List<int> bytes, String localPath, String fileName) async {
    final path = await getDocumentDirectory() +
        localPath; // todo need to create path if not exist
    final file = File('$path/$fileName');
    return file.writeAsBytes(bytes);
  }
}
