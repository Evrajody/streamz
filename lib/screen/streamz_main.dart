import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:streamz/Https/anime_service.dart';
import 'package:streamz/Https/request_service.dart';
import 'package:streamz/models/anime_result.dart';
import 'package:get/get.dart';
import 'package:streamz/screen/no_internet_screen.dart';
import 'package:streamz/tools/network_manager.dart';
import 'package:streamz/tools/streamz_constants.dart';
import 'package:streamz/widgets/animecard.dart';

class StreamzMain extends StatefulWidget {
  const StreamzMain({Key? key}) : super(key: key);
  @override
  State<StreamzMain> createState() => _StreamzMainState();
}

class _StreamzMainState extends State<StreamzMain> {
  final networkManager = Get.find<NetworkManager>();
  Random ramdomer = Random();
  int numrandom = 0;

  @override
  void initState() {
    super.initState();
    numrandom = ramdomer.nextInt(527);
  }

  @override
  Widget build(BuildContext context) {
    final requestService = Provider.of<RequestService>(context, listen: false);
    return GetBuilder<NetworkManager>(
      builder: (_) => networkManager.userIsOnline
          ? FutureBuilder<List<AnimeResults>>(
              future: Future.wait([
                AnimeService().getAnimes(
                    requestService.requestRandomPopularResponse(numrandom)),
                AnimeService().getRecentlyAddedAnimes(),
                AnimeService()
                    .getAnimes(requestService.requestMoviesResponse()),
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  final popularList = snapshot.data![0].animeList;
                  final recentlyAdded = snapshot.data![1].animeList;
                  final movieList = snapshot.data![2].animeList;
                  return Scaffold(
                    backgroundColor: erieBlack,
                    body: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 45),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Animations",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Populaires",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
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
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: popularList!.length,
                                  itemBuilder: (context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        horizontalOffset: -60,
                                        child: FadeInAnimation(
                                          child: AnimeCard(
                                            anime: popularList[index],
                                            animeCardHeight: 180,
                                            animeCardWidth: 220,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Recemment",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Ajoutés",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
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
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recentlyAdded!.length,
                                  itemBuilder: (context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        // horizontalOffset: -60,
                                        child: FadeInAnimation(
                                          child: AnimeCard(
                                            anime: recentlyAdded[index],
                                            animeCardHeight: 220,
                                            animeCardWidth: 160,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Recommendations",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
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
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieList!.length,
                                  itemBuilder: (context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        // horizontalOffset: -60,
                                        child: FadeInAnimation(
                                          child: AnimeCard(
                                            anime: movieList[index],
                                            animeCardHeight: 220,
                                            animeCardWidth: 160,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: erieBlack,
                    body: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              })
          : Scaffold(
              backgroundColor: erieBlack,
              body: const Center(
                child: NoInternetScreen(),
              ),
            ),
    );
  }
}
