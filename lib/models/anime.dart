///*
/// Ici une classe modele decrivant les caracteristiques princippales d'un anime
/// C'est le modele de base des informations manipulé concernant les animées !!
class Anime {
  Anime({
    this.id,
    this.name,
    this.imageUrl,
    this.status,
    this.summary,
    this.genres,
    this.epLinks,
    this.currentEp,
    this.animeUrl,
    this.releasedDate,
  });

  final String? id;
  final String? name;
  final String? imageUrl;
  final String? summary;
  final String? status;
  final String? animeUrl;
  final List<String>? genres;
  final List<String>? epLinks;
  final String? currentEp;
  final String? releasedDate;
}
