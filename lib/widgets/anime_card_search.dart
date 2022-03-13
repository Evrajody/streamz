import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamz/models/anime.dart';
import 'package:streamz/screen/anime_page_view.dart';

class AnimeCardSearch extends StatelessWidget {
  final Anime anime;
  final double animeCardWidth;
  final double animeCardHeight;

  const AnimeCardSearch({
    required this.anime,
    this.animeCardHeight = 150,
    this.animeCardWidth = 200,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: anime.id.toString(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                if (anime.currentEp == null) {
                  Get.to(() => const AnimePageView(), arguments: {
                    'anime': anime,
                  });
                } else {}
              },
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                elevation: 2.8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                      image: NetworkImage(anime.imageUrl.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: animeCardHeight,
                  width: animeCardWidth,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
