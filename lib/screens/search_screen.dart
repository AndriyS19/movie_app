import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_movie_app/controllers/search_controller.dart';
import 'package:the_movie_app/model/movie_model.dart';
import 'package:the_movie_app/screens/details_screen.dart';
import 'package:the_movie_app/services/app_key.dart';
import 'package:the_movie_app/widgets/infos.dart';
import 'package:the_movie_app/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 35,
                  fontFamily: "Comfortaa",
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SearchBox(
              onSumbit: () {
                String search =
                    Get.find<SearchController>().searchController.text;
                Get.find<SearchController>().searchController.text = '';
                Get.find<SearchController>().search(search);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 34,
            ),
            Obx(
              (() => Get.find<SearchController>().isLoading.value
                  ? const CircularProgressIndicator()
                  : Get.find<SearchController>().foundedMovies.isEmpty
                      ? SizedBox(
                          width: Get.width / 1.5,
                          child: const Center(
                            child: Opacity(
                              opacity: .8,
                              child: Text(
                                'Find your movie by Type title, categories, years, etc ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount:
                              Get.find<SearchController>().foundedMovies.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 24),
                          itemBuilder: (_, index) {
                            Movie movie = Get.find<SearchController>()
                                .foundedMovies[index];
                            return GestureDetector(
                              onTap: () => Get.to(DetailsScreen(movie: movie)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      Api.imageBaseUrl + movie.posterPath,
                                      height: 180,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.broken_image,
                                        size: 120,
                                      ),
                                      loadingBuilder: (_, __, ___) {
                                        if (___ == null) return __;
                                        return const FadeShimmer(
                                          width: 120,
                                          height: 180,
                                          highlightColor: Color(0xff22272f),
                                          baseColor: Color(0xff20252d),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Infos(movie: movie)
                                ],
                              ),
                            );
                          },
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
