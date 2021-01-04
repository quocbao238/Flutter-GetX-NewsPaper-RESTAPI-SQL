import 'package:html_unescape/html_unescape.dart';

class StringHelper {
  static HtmlUnescape unescape = HtmlUnescape();
  // Convert html -> String
  static convertHtmlToString(String htmlStr) {
    return unescape.convert(htmlStr);
  }
}
