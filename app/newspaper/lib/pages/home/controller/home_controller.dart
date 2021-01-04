import 'package:get/get.dart';
import 'package:newspaper/models/category_model.dart';
import 'package:newspaper/models/news_model.dart';
import 'package:newspaper/pages/tab/controller/tab_page_controller.dart';
import 'package:newspaper/providers/api.dart';

class HomeController extends GetxController {
  TabPageController tabPageController;
  RxList<News> listNews = RxList<News>([]);
  RxList<CategoryModel> listCategoryTitle = RxList<CategoryModel>([]);
  RxInt categoryIdSelect = RxInt(1);
  RxList<News> listCategoryData = RxList<News>([]);
  RxBool isloadingCategoryData = RxBool(true);

  @override
  void onInit() {
    tabPageController = Get.find();
    fetchData();
    super.onInit();
  }

  fetchData() async {
    print('FetchData');
    try {
      listNews.assignAll(await getNewNews());
      listCategoryTitle.assignAll(await getCategories());
      listCategoryData
          .assignAll(await getNewsByCategoryId(categoryIdSelect.value));
      tabPageController.onChangeLoading(false);
    } catch (e) {
      tabPageController.onChangeLoading(false);
    }
  }

  Future<List<News>> getNewNews() async {
    List<News> _lstNews;
    try {
      _lstNews = await Api.fetchNewNews();
    } catch (e) {}
    return _lstNews;
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> _lstCategory;
    try {
      _lstCategory = await Api.fetchCategories();
    } catch (e) {}
    return _lstCategory;
  }

  Future<List<News>> getNewsByCategoryId(index) async {
    isloadingCategoryData.value = true;
    List<News> _lstNewsById;
    try {
      _lstNewsById = await Api.getNewsByCategoryById(index);
    } catch (e) {}
    isloadingCategoryData.value = false;
    return _lstNewsById;
  }

  onTapCategory(int index) async {
    categoryIdSelect.value = index;
    listCategoryData
        .assignAll(await getNewsByCategoryId(categoryIdSelect.value));
  }

  onTapFavorite({News news, bool isTopNews = false}) async {
    if (isTopNews) {
      int index = listNews.indexOf(news);
      listNews[index].favorite = !news.favorite;
    } else {
      int index = listCategoryData.indexOf(news);
      listCategoryData[index].favorite = !news.favorite;
    }
    print(listNews);
  }
}
