import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/models/anime.dart';
import 'package:streamz/screen/anime_page_view.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final double animeCardWidth;
  final double animeCardHeight;

  const AnimeCard({
    required this.anime,
    required this.animeCardHeight,
    required this.animeCardWidth,
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
                } else {
                  print("Okay");
                }
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
        const SizedBox(height: 5),
        Expanded(
          child: SizedBox(
            width: animeCardWidth,
            child: Center(
              child: Text(
                anime.name.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: animeCardWidth,
            child: Center(
              child: anime.currentEp != null
                  ? Text(
                      anime.currentEp.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )
                  : const Text(""),
            ),
          ),
        ),
      ],
    );
  }
}
