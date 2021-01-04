import 'package:newspaper/models/category_model.dart';
import 'package:newspaper/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:newspaper/setting/app_setting.dart';

class Api {
  static var client = http.Client();

  static Future<List<News>> fetchNewNews() async {
    try {
      var response = await client.get(AppSetting.api + "news");
      if (response.statusCode == 200) {
        var jsonStr = response.body;
        return newsModelFromJson(jsonStr).news;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<CategoryModel>> fetchCategories() async {
    try {
      var response = await client.get(AppSetting.api + "categories");
      if (response.statusCode == 200) {
        var jsonStr = response.body;
        return categoryFromJson(jsonStr).categories;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<News>> getNewsByCategoryById(int categoryId) async {
    try {
      var response =
          await client.get(AppSetting.api + "newsbycategoryid/$categoryId");
      if (response.statusCode == 200) {
        var jsonStr = response.body;
        return newsModelFromJson(jsonStr).news;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
