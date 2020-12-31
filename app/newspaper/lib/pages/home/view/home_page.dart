import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper/pages/home/controller/home_controller.dart';
import 'package:newspaper/widget/loading_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return homeController.isLoading.value ? LoadingWidget() : buildBody();
        });
  }

  Widget buildBody() {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 16, top: 16, right: 8, bottom: 16),
                    child: Text(
                      "Tin mới nhất",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 230.0,
                    margin: EdgeInsets.only(left: 16.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(right: 10.0),
                        width: Get.width * 0.85,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://avatars0.githubusercontent.com/u/51372227?s=460&u=ddc0aa1176a6229ef199b56f5cf0c834517f2742&v=4",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget appBar() => AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
            height: 30.0,
            width: 30.0,
            margin: EdgeInsets.only(right: 10),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  'https://avatars0.githubusercontent.com/u/51372227?s=460&u=ddc0aa1176a6229ef199b56f5cf0c834517f2742&v=4',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
        title: Text(
          "Trang chủ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onPressed: () {}),
      );
}
