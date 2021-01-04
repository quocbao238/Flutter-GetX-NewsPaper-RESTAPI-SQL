// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.news,
  });

  List<News> news;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
      };
}

class News {
  News({this.favorite, this.id, this.image, this.publishDate, this.subject});

  bool favorite;
  int id;
  String image;
  DateTime publishDate;
  String subject;

  factory News.fromJson(Map<String, dynamic> json) => News(
        favorite: json["favorite"],
        id: json["id"],
        image: json["image"],
        publishDate: DateTime.parse(json["publish_date"]),
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "favorite": favorite,
        "id": id,
        "image": image,
        "publish_date": publishDate.toIso8601String(),
        "subject": subject,
      };
}
