import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabPageController extends GetxController {
  final currentIndex = 0.obs;
  final isLoading = true.obs;
  final strAppBar = "Bảng tin".obs;
  PageController controller;

  @override
  void onInit() {
    controller = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onChangeLoading(bool loading) {
    isLoading.value = loading;
    update();
  }

  onTapBottomNavigationBar(int index) {
    controller.jumpToPage(index);
    currentIndex.value = index;
    strAppBar.value = index == 0 ? "Bảng tin" : "Yêu thích";
    update();
  }
}
