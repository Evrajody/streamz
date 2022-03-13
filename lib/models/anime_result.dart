import 'package:streamz/models/anime.dart';

///Une classe basé sur la récuperation d'une liste d'animé

class AnimeResults {
  AnimeResults({
    required this.animeList,
  });

  final List<Anime>? animeList;
}
