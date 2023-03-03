import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:the_movie_app/model/movie_model.dart';
import 'package:the_movie_app/utils/utils.dart';

class Infos extends StatelessWidget {
  const Infos({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
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
                    size: 5,
                  ),
                  Text(
                    movie.voteAverage == 0.0
                        ? 'N/A'
                        : movie.voteAverage.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFF8700),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.ticket,
                    color: Colors.grey,
                    size: 15,
                  ),
                  Text(
                    Utils.getGenres(movie),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
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
                      fontSize: 16,
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
