class RecommendedTile {
  static const String titleKey = 'name';
  static const String subtitleKey = 'game_name';
  static const String imageUrlKey = 'cover_url';
  static const String urlKey = 'tournament_url';

  String title;
  String subtitle;
  String imageUrl;
  String url;

  RecommendedTile({required this.title, required this.imageUrl, required this.subtitle, required this.url});

  factory RecommendedTile.fromJson(Map<dynamic, dynamic> json) => RecommendedTile(
    title: json[titleKey],
    subtitle: json[subtitleKey],
    imageUrl: json[imageUrlKey],
    url: json[urlKey]
  );

  Map<String, dynamic> toJson() =>
      {
        titleKey: title,
        subtitleKey: subtitle,
        imageUrlKey: imageUrl,
        urlKey: url
      };
}
