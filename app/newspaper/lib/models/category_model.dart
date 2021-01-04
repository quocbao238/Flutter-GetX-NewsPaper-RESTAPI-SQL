import 'dart:convert';

Categorires categoryFromJson(String str) =>
    Categorires.fromJson(json.decode(str));

String categoryToJson(Categorires data) => json.encode(data.toJson());

class Categorires {
  Categorires({this.categories});
  List<CategoryModel> categories;
  factory Categorires.fromJson(Map<String, dynamic> json) => Categorires(
      categories: List<CategoryModel>.from(
          json["categories"].map((x) => CategoryModel.fromJson(x))));
  Map<String, dynamic> toJson() =>
      {"categories": List<dynamic>.from(categories.map((x) => x.toJson()))};
}

class CategoryModel {
  CategoryModel({this.id, this.name, this.url});
  int id;
  String name, url;
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(id: json["id"], name: json["name"], url: json["url"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name, "url": url};
}
