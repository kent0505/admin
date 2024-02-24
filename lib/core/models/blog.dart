class Blog {
  final int id;
  final String title;
  final int index;
  final int date;
  final int cid;

  Blog({
    required this.id,
    required this.title,
    required this.index,
    required this.date,
    required this.cid,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      index: json['index'],
      date: json['date'],
      cid: json['cid'],
    );
  }
}

class BlogModel {
  final int? id;
  final String title;
  final String index;
  final String cid;

  BlogModel({
    this.id,
    required this.title,
    required this.index,
    required this.cid,
  });
}
