// To parse this JSON data, do
//
//     final jsonResponseComments = jsonResponseCommentsFromJson(jsonString);

import 'dart:convert';
import 'Image.dart';

JsonResponseComments jsonResponseCommentsFromJson(String str) =>
    JsonResponseComments.fromJson(json.decode(str));

class JsonResponseComments {
  Meta meta;
  Response response;

  JsonResponseComments({
    this.meta,
    this.response,
  });

  factory JsonResponseComments.fromJson(Map<String, dynamic> json) =>
      JsonResponseComments(
        meta: Meta.fromJson(json["meta"]),
        response: Response.fromJson(json["response"]),
      );
}

class Meta {
  int code;
  String requestId;

  Meta({
    this.code,
    this.requestId,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        requestId: json["requestId"],
      );
}

class Response {
  Tips tips;

  Response({
    this.tips,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        tips: Tips.fromJson(json["tips"]),
      );
}

class Tips {
  int count;
  List<Comment> comments;

  Tips({
    this.count,
    this.comments,
  });

  factory Tips.fromJson(Map<String, dynamic> json) => Tips(
        count: json["count"],
        comments:
            List<Comment>.from(json["items"].map((x) => Comment.fromJson(x))),
      );
}

class Comment {
  String id;
  int createdAt;
  String text;
  String type;
  String canonicalUrl;
  ItemPhoto photo;
  String photourl;
  Likes likes;
  bool logView;
  int agreeCount;
  int disagreeCount;
  Todo todo;
  User user;
  String authorInteractionType;

  Comment({
    this.id,
    this.createdAt,
    this.text,
    this.type,
    this.canonicalUrl,
    this.photo,
    this.photourl,
    this.likes,
    this.logView,
    this.agreeCount,
    this.disagreeCount,
    this.todo,
    this.user,
    this.authorInteractionType,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        createdAt: json["createdAt"],
        text: json["text"],
        type: json["type"],
        canonicalUrl: json["canonicalUrl"],
        //photo: ItemPhoto.fromJson(json["photo"]),
        photourl: json["photourl"],
        //likes: Likes.fromJson(json["likes"]),
        logView: json["logView"],
        agreeCount: json["agreeCount"],
        disagreeCount: json["disagreeCount"],
        todo: Todo.fromJson(json["todo"]),
        user: User.fromJson(json["user"]),
        authorInteractionType: json["authorInteractionType"],
      );
}

class Likes {
  int count;
  List<dynamic> groups;

  Likes({
    this.count,
    this.groups,
  });

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        count: json["count"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
      );
}

class ItemPhoto {
  String id;
  int createdAt;
  Source source;
  String prefix;
  String suffix;
  int width;
  int height;
  String visibility;

  ItemPhoto({
    this.id,
    this.createdAt,
    this.source,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
    this.visibility,
  });

  factory ItemPhoto.fromJson(Map<String, dynamic> json) => ItemPhoto(
        id: json["id"],
        createdAt: json["createdAt"],
        source: Source.fromJson(json["source"]),
        prefix: json["prefix"],
        suffix: json["suffix"],
        width: json["width"],
        height: json["height"],
        visibility: json["visibility"],
      );
}

class Todo {
  int count;

  Todo({
    this.count,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        count: json["count"],
      );
}

class UserPhoto {
  String prefix;
  String suffix;

  UserPhoto({
    this.prefix,
    this.suffix,
  });

  factory UserPhoto.fromJson(Map<String, dynamic> json) => UserPhoto(
        prefix: json["prefix"],
        suffix: json["suffix"],
      );
}
