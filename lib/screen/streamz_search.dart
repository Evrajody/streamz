import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:streamz/https/anime_service.dart';
import 'package:streamz/https/request_service.dart';
import 'package:streamz/models/anime_result.dart';
import 'package:streamz/screen/no_internet_screen.dart';
import 'package:streamz/tools/network_manager.dart';
import 'package:streamz/tools/streamz_constants.dart';
import 'package:streamz/widgets/anime_card_search.dart';
import 'package:streamz/widgets/animecard.dart';
import 'package:streamz/widgets/default_search.dart';

class StreamzSearch extends StatefulWidget {
  const StreamzSearch({Key? key}) : super(key: key);

  @override
  State<StreamzSearch> createState() => _StreamzSearchState();
}

class _StreamzSearchState extends State<StreamzSearch> {
  final TextEditingController searchcontroller = TextEditingController();
  String seacher = '';
  final _formSeachKey = GlobalKey<FormState>();
  final networkManager = Get.find<NetworkManager>();
  dynamic fetchingData;
  int numrandom = 0;
  bool _isTapped = true;
  Random ramdomer = Random();

  @override
  void initState() {
    super.initState();
    final requestService = Provider.of<RequestService>(context, listen: false);
    numrandom = ramdomer.nextInt(527);

    fetchingData = Future.wait([
      AnimeService()
          .getAnimes(requestService.requestRandomPopularResponse(numrandom)),
      AnimeService().getAnimes(requestService.requestNewRelease()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
      builder: (_) => networkManager.userIsOnline
          ? FutureBuilder<List<AnimeResults>>(
              future: fetchingData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    backgroundColor: erieBlack,
                    body: Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Une erreur s'est produite"),
                        ],
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  final mostSearched = snapshot.data![0].animeList;
                  final newRelased = snapshot.data![1].animeList;

                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: erieBlack,
                      elevation: 0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _isTapped = false;
                                });
                              } else {
                                setState(() {
                                  _isTapped = true;
                                });
                              }
                            },
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                CupertinoIcons.mic_fill,
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade700),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade700,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey.shade900),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade700),
                              ),
                            ),
                            key: _formSeachKey,
                            controller: searchcontroller,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: erieBlack,
                    body: _isTapped == true
                        ? Defaultsearch(
                            mostSearched: mostSearched,
                            newRelased: newRelased,
                          )
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  "Meilleurs Resultats Trouvés",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: AnimationLimiter(
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.0,
                                        ),
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: mostSearched!.length,
                                        itemBuilder: (context, int index) {
                                          return AnimationConfiguration
                                              .staggeredList(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 600),
                                            child: SlideAnimation(
                                              horizontalOffset: -60,
                                              child: FadeInAnimation(
                                                child: AnimeCardSearch(
                                                  anime: mostSearched[index],
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
