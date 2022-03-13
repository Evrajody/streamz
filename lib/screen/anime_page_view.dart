import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/https/anime_service.dart';
import 'package:streamz/models/anime.dart';
import 'package:streamz/screen/cache_image_with_cachemanager.dart';
import 'package:streamz/tools/streamz_constants.dart';
import 'package:streamz/tools/streamz_routes.dart';
import 'package:streamz/widgets/anime_detail_header.dart';

/// Classe grerant la vue des animées en detail
/// Images, Listes des episodes et liens pour les vidéos
class AnimePageView extends StatefulWidget {
  const AnimePageView({Key? key}) : super(key: key);

  @override
  State<AnimePageView> createState() => _AnimePageViewState();
}

class _AnimePageViewState extends State<AnimePageView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final name = Get.arguments['anime'].name.toString();
  final imageUrl = Get.arguments['anime'].imageUrl.toString();
  final animeUrl = Get.arguments['anime'].animeUrl.toString();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Get.arguments['anime'].id.toString(),
      child: Scaffold(
        key: _formKey,
        backgroundColor: erieBlack,
        appBar: AppBar(
          backgroundColor: erieBlack,
          elevation: 0,
          title: Text(
            name.toString(),
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: FutureBuilder<Anime>(
          future: AnimeService().fetchAnimeDetails(animeUrl),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              //print(snapshot.error.toString());
              return Center(
                child: Column(
                  children: [
                    Text(
                      'An Error ccurred',
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white),
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final anime = snapshot.data;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: NetworkImageWithCacheManager(
                      imageUrl: imageUrl,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Container(
                      color: Colors.black54,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: ListView(
                      children: [
                        AnimeDetailHeader(
                          anime: anime!,
                          imageUrl: imageUrl,
                          name: name,
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height - 400,
                          child: anime.epLinks!.isNotEmpty
                              ? ListView.builder(
                                  itemCount: anime.epLinks!.length,
                                  itemBuilder: (context, int index) {
                                    return SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await Get.toNamed(
                                                  StreamzRoutes
                                                      .mediaFetchScreen,
                                                  arguments: {
                                                    'animeUrl': anime
                                                        .epLinks![index]
                                                        .toString()
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    erieBlack.withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              height: 80,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20,
                                              child: Center(
                                                child: Text(
                                                  "Episode ${index + 1}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    'Coming Soon ..',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Center(
                      child: Container(
                        color: Colors.black87,
                        width: double.infinity,
                        height: double.infinity,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
