import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));
String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  List<Comment> comment;
  CommentModel({this.comment});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      comment:
          List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({this.content, this.id, this.timeCreate});

  String content;
  int id;
  dynamic timeCreate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      content: json["content"],
      id: json["id"],
      timeCreate: json["time_create"]);

  Map<String, dynamic> toJson() =>
      {"content": content, "id": id, "time_create": timeCreate};
}
