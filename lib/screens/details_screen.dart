import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:the_movie_app/controllers/movies_controller.dart';
import 'package:the_movie_app/model/movie_model.dart';
import 'package:the_movie_app/services/api_service.dart';
import 'package:the_movie_app/services/app_key.dart';
import 'package:the_movie_app/utils/utils.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    ApiService.getMovieReviews(movie.id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detail',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          fontFamily: "Comfortaa"),
                    ),
                    Tooltip(
                      message: 'Save this movie to your watch list',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchList(movie);
                        },
                        icon: Obx(
                          () =>
                              Get.find<MoviesController>().isInWatchList(movie)
                                  ? const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 33,
                                    )
                                  : const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.white,
                                      size: 33,
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        Api.imageBaseUrl + movie.backdropPath,
                        width: Get.width,
                        height: 250,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, __, ___) {
                          if (___ == null) return __;
                          return FadeShimmer(
                            width: Get.width,
                            height: 250,
                            highlightColor: const Color(0xff22272f),
                            baseColor: const Color(0xff20252d),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 110,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Comfortaa",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.star,
                              color: Color(0xFFFF8700),
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text(
                              movie.voteAverage == 0.0
                                  ? 'N/A'
                                  : movie.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                                fontFamily: "Comfortaa",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Opacity(
                opacity: .6,
                child: SizedBox(
                  width: Get.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.calendar,
                            color: Colors.grey,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            movie.releaseDate.split('-')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: "Comfortaa",
                            ),
                          ),
                        ],
                      ),
                      const Text('|'),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.ticket,
                            color: Colors.grey,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 120,
                            child: AutoSizeText(
                              Utils.getGenres(movie),
                              maxLines: 2,
                              maxFontSize: 20,
                              minFontSize: 14,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Comfortaa",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      "Overview",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.overview,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
