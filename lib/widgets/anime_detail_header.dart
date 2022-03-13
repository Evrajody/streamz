import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/models/anime.dart';
import 'package:streamz/screen/cache_image_with_cachemanager.dart';

class AnimeDetailHeader extends StatelessWidget {
  const AnimeDetailHeader({
    Key? key,
    required this.anime,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);
  final Anime anime;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 280,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(08),
                  child: NetworkImageWithCacheManager(
                    imageUrl: imageUrl,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: 'Released : ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
                        ),
                        TextSpan(
                          text: anime.releasedDate.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Status : ',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
                          ),
                          TextSpan(
                            text: anime.status.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
                          ),
                        ]),
                      )),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Wrap(
                      children: anime.genres!
                          .map((genre) => Transform(
                                transform: Matrix4.identity()..scale(0.8),
                                child: Chip(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    label: Text(genre.toString())),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
