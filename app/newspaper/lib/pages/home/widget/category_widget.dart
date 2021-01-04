import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newspaper/models/category_model.dart';
import 'package:newspaper/models/news_model.dart';
import 'package:newspaper/pages/home/controller/home_controller.dart';

class CategoryWidget extends StatelessWidget {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Column(children: [_titleList(), _dataList()]));

  Widget _dataList() => Container(
      margin: EdgeInsets.only(right: 16.0, top: 16.0),
      child: Obx(() => homeController.isloadingCategoryData.value
          ? Container()
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeController.listCategoryData.length,
              itemBuilder: (context, index) =>
                  __dataItem(homeController.listCategoryData[index]))));

  Widget __dataItem(News news) => Container(
        margin: EdgeInsets.only(bottom: 16.0),
        height: 130.0,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black26, width: 1),
          color: Colors.white,
        ),
        child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      imageUrl: news.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 8.0, right: 8.0),
                            child: Text(
                              news.subject,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                DateFormat('hh:mm dd/MM/yyyy')
                                    .format(news.publishDate),
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey)),
                            InkWell(
                                onTap: () {},
                                child: Icon(Icons.favorite, color: Colors.red)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _titleList() => Container(
        height: 40.0,
        child: Obx(() => ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeController.listCategoryTitle.length,
            itemBuilder: (context, index) =>
                __itemTitle(homeController.listCategoryTitle[index]))),
      );

  Widget __itemTitle(CategoryModel categoryElement) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.only(bottom: 3.0),
      child: RaisedButton(
        onPressed: () => homeController.onTapCategory(categoryElement.id),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.white,
        child: Center(
          child: Obx(() => Text(
                categoryElement.name,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                    color: homeController.categoryIdSelect.value ==
                            categoryElement.id
                        ? Colors.red
                        : Colors.black87),
              )),
        ),
      ),
    );
  }
}
