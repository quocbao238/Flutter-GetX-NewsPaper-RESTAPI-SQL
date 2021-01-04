import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper/pages/favorite/view/favorite_page.dart';
import 'package:newspaper/pages/home/view/home_page.dart';
import 'package:newspaper/pages/tab/controller/tab_page_controller.dart';
import 'package:newspaper/setting/app_setting.dart';
import 'package:newspaper/widget/loading_widget.dart';

class TabsPage extends StatelessWidget {
  final List<Widget> bodyWidget = [HomePage(), FavoritePage()];

  @override
  Widget build(BuildContext context) => GetBuilder<TabPageController>(
      init: TabPageController(),
      builder: (tabController) {
        return Stack(
          children: [
            Scaffold(
              appBar: appBar(),
              body: PageView(
                  controller: tabController.controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: bodyWidget),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabController.currentIndex.value,
                onTap: (int index) =>
                    tabController.onTapBottomNavigationBar(index),
                items: [
                  BottomNavigationBarItem(
                      label: "Bảng tin", icon: Icon(Icons.dashboard)),
                  BottomNavigationBarItem(
                      label: "Yêu thích", icon: Icon(Icons.favorite))
                ],
              ),
            ),
            tabController.isLoading.value ? LoadingWidget() : SizedBox()
          ],
        );
      });

  Widget appBar() {
    TabPageController tabPageController = Get.find();
    return AppBar(
      backgroundColor: AppSetting.colorPrimary,
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
                        fit: BoxFit.fill))))
      ],
      title: Obx(() => Text("${tabPageController.strAppBar}",
          style: TextStyle(color: Colors.black))),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
          onPressed: () {}),
    );
  }
}
