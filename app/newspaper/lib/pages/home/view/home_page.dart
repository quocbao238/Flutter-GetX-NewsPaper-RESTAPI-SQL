import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper/pages/home/controller/home_controller.dart';
import 'package:newspaper/pages/home/widget/category_widget.dart';
import 'package:newspaper/pages/home/widget/new_news_widget.dart';
import 'package:newspaper/setting/app_setting.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      init: HomeController(), builder: (homeController) => buildBody());

  Widget buildBody() => Scaffold(
      backgroundColor: AppSetting.colorBackground,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [NewNewsWidget(), CategoryWidget()],
        ),
      ));
}
