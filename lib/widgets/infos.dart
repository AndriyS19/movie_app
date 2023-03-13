import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:the_movie_app/model/movie_model.dart';
import 'package:the_movie_app/utils/utils.dart';

class Infos extends StatelessWidget {
  const Infos({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 150,
            child: AutoSizeText(
              movie.title,
              maxLines: 3,
              minFontSize: 14,
              maxFontSize: 20,
              style: const TextStyle(
                fontFamily: "Comfortaa",
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.star,
                    color: Colors.grey,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  AutoSizeText(
                    movie.voteAverage == 0.0
                        ? 'N/A'
                        : movie.voteAverage.toString(),
                    maxLines: 3,
                    minFontSize: 12,
                    maxFontSize: 20,
                    style: const TextStyle(
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.w200,
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFFFF8700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
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
                      maxLines: 3,
                      minFontSize: 14,
                      maxFontSize: 20,
                      style: const TextStyle(
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w200,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
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
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
