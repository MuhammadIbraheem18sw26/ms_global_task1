import 'dart:convert';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.body,
  });

  int id;
  int userId;
  String title;
  String body;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        userId: json["userId"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": title,
        "userId": userId,
        "body": body,
      };
}
