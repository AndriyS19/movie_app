import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/controllers/bottom_navigator_controller.dart';

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);
  final BottomNavigatorController controller =
      Get.put(BottomNavigatorController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: IndexedStack(
            index: controller.index.value,
            children: Get.find<BottomNavigatorController>().screens,
          ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (index) =>
                  Get.find<BottomNavigatorController>().setIndex(index),
              backgroundColor: const Color(0xFF242A32),
              selectedItemColor: const Color(0xFF0296E5),
              unselectedItemColor: const Color(0xFF67686D),
              selectedFontSize: 12,
              unselectedFontSize: 10,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: Icon(
                      CupertinoIcons.home,
                      color: controller.index.value == 0
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                      size: 30,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: Icon(
                      CupertinoIcons.search,
                      color: controller.index.value == 1
                          ? Color.fromARGB(255, 15, 165, 246)
                          : const Color(0xFF67686D),
                      size: 30,
                    ),
                  ),
                  label: 'Search',
                  tooltip: 'Search Movies',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: Icon(
                      CupertinoIcons.bookmark,
                      size: 30,
                      color: controller.index.value == 2
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Saved list',
                  tooltip: 'Your SavedList',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
