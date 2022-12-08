class TasModel {
  String title;
  String description;
  String date;
  String category;
  bool status;

  TasModel({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.status,
  });

  factory TasModel.fromJson(Map<String, dynamic> json) => TasModel(
        title: json["title"],
        description: json["description"],
        date: json["date"],
        category: json["category"],
        status: json["status"],
      );
}
