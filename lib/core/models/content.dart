class Content {
  final int id;
  final String title;
  final int index;
  final int image;
  final int bid;

  Content({
    required this.id,
    required this.title,
    required this.index,
    required this.image,
    required this.bid,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      title: json['title'],
      index: json['index'],
      image: json['image'],
      bid: json['bid'],
    );
  }
}
