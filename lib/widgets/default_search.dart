
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/models/anime.dart';
import 'package:streamz/widgets/animecard.dart';

class Defaultsearch extends StatelessWidget {
  const Defaultsearch({
    Key? key,
    required this.mostSearched,
    required this.newRelased,
  }) : super(key: key);

  final List<Anime>? mostSearched;
  final List<Anime>? newRelased;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Que rechercher vous ?",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Text(
                      "Trouver des centaines d'animations dont vos animés favorites !",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Les plus recherchés",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Voir plus",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 280,
            child: AnimationLimiter(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: mostSearched!.length,
                  itemBuilder: (context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      child: SlideAnimation(
                        // horizontalOffset: -60,
                        child: FadeInAnimation(
                          child: AnimeCard(
                            anime: mostSearched![index],
                            animeCardHeight: 220,
                            animeCardWidth: 180,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Cette Année ${DateTime.now().year}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Voir plus",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 280,
            child: AnimationLimiter(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: newRelased!.length,
                  itemBuilder: (context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      child: SlideAnimation(
                        // horizontalOffset: -60,
                        child: FadeInAnimation(
                          child: AnimeCard(
                            anime: newRelased![index],
                            animeCardHeight: 220,
                            animeCardWidth: 180,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
