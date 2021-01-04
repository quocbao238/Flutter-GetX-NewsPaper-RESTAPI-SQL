import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newspaper/models/news_model.dart';
import 'package:newspaper/pages/home/controller/home_controller.dart';

class NewNewsWidget extends StatelessWidget {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) => Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_title(), _listNews()]));

  Widget _listNews() => Container(
        height: 220,
        margin: EdgeInsets.only(left: 16.0),
        child: Obx(() => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: homeController.listNews.length,
              itemBuilder: (context, index) =>
                  _itemNews(homeController.listNews[index]),
            )),
      );

  Widget _itemNews(News news) => Container(
        padding: EdgeInsets.only(bottom: 2.0),
        child: Container(
          width: Get.width * 0.55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0.25, 2),
                  spreadRadius: 1),
            ],
          ),
          margin: EdgeInsets.only(right: 15.0),
          child: FlatButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.transparent)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 100,
                  width: Get.width * 0.65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15.0)),
                    child: CachedNetworkImage(
                      imageUrl: news.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 8.0, right: 8.0, bottom: 8.0),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('hh:mm dd/MM/yyyy')
                                .format(news.publishDate),
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                          ),
                          IconButton(
                            icon: Icon(
                                news.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    news.favorite ? Colors.red : Colors.grey),
                            onPressed: () => homeController.onTapFavorite(
                                news: news, isTopNews: true),
                          )
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      );

  Widget _title() => Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 8, bottom: 16),
      child: Text("Tin mới nhất",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
}
