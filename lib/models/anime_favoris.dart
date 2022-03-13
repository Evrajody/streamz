// Une classe modelisant les animés favorites de l'utilisateurs;

class AnimeFavoris {
  AnimeFavoris({
    required this.id,
    required this.name,
    required this.animeUrl,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String animeUrl;
  final String imageUrl;

  factory AnimeFavoris.fromJson(Map<String, dynamic> json) => AnimeFavoris(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        animeUrl: json['animeUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'animeUrl': animeUrl,
      };
}
