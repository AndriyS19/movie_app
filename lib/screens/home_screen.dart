import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/controllers/bottom_navigator_controller.dart';
import 'package:the_movie_app/controllers/movies_controller.dart';
import 'package:the_movie_app/controllers/search_controller.dart';
import 'package:the_movie_app/services/api_service.dart';
import 'package:the_movie_app/services/app_key.dart';
import 'package:the_movie_app/widgets/search_box.dart';
import 'package:the_movie_app/widgets/tab_builder.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final MoviesController controller = Get.put(MoviesController());
  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Movie App',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  fontFamily: "Comfortaa",
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SearchBox(
              onSumbit: () {
                String search =
                    Get.find<SearchController>().searchController.text;
                Get.find<SearchController>().searchController.text = '';
                Get.find<SearchController>().search(search);
                Get.find<BottomNavigatorController>().setIndex(1);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 34,
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TabBar(
                    indicatorWeight: 2,
                    indicatorColor: Color(
                      0xFF3A3F47,
                    ),
                    tabs: [
                      Tab(text: 'Top rated'),
                      Tab(text: 'Popular'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 450,
                    child: TabBarView(
                      children: [
                        TabBuilder(
                          future: ApiService.getCustomMovies(
                              'top_rated?api_key=${Api.apiKey}&language=en-US&page=1'),
                        ),
                        TabBuilder(
                          future: ApiService.getCustomMovies(
                              'popular?api_key=${Api.apiKey}&language=en-US&page=1'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
