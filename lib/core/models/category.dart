class Category {
  final int id;
  final String title;
  final int index;
  final int type;

  Category({
    required this.id,
    required this.title,
    required this.index,
    required this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      index: json['index'],
      type: json['type'],
    );
  }
}
