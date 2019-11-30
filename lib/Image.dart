import 'dart:convert';

JsonResponseImages jsonResponseImagesFromJson(String str) =>
    JsonResponseImages.fromJson(json.decode(str));

class JsonResponseImages {
  Meta meta;
  Response response;

  JsonResponseImages({
    this.meta,
    this.response,
  });

  factory JsonResponseImages.fromJson(Map<String, dynamic> json) =>
      JsonResponseImages(
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
  Photos photos;

  Response({
    this.photos,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        photos: Photos.fromJson(json["photos"]),
      );
}

class Photos {
  int count;
  List<Item> items;
  int dupesRemoved;

  Photos({
    this.count,
    this.items,
    this.dupesRemoved,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        count: json["count"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        dupesRemoved: json["dupesRemoved"],
      );

  List<Item> getItems() {
    return this.items;
  }
}

class Item {
  String id;
  int createdAt;
  Source source;
  String prefix;
  String suffix;
  int width;
  int height;
  User user;
  Checkin checkin;
  String visibility;

  Item({
    this.id,
    this.createdAt,
    this.source,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
    this.user,
    this.checkin,
    this.visibility,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        createdAt: json["createdAt"],
        source: Source.fromJson(json["source"]),
        prefix: json["prefix"],
        suffix: json["suffix"],
        width: json["width"],
        height: json["height"],
        user: User.fromJson(json["user"]),
        checkin: Checkin.fromJson(json["checkin"]),
        visibility: json["visibility"],
      );
}

class Checkin {
  String id;
  int createdAt;
  String type;
  int timeZoneOffset;

  Checkin({
    this.id,
    this.createdAt,
    this.type,
    this.timeZoneOffset,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["id"],
        createdAt: json["createdAt"],
        type: json["type"],
        timeZoneOffset: json["timeZoneOffset"],
      );
}

class Source {
  String name;
  String url;

  Source({
    this.name,
    this.url,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"],
        url: json["url"],
      );
}

class User {
  String id;
  String firstName;
  String lastName;
  String gender;
  Photo photo;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        photo: Photo.fromJson(json["photo"]),
      );
}

class Photo {
  String prefix;
  String suffix;

  Photo({
    this.prefix,
    this.suffix,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        prefix: json["prefix"],
        suffix: json["suffix"],
      );
}
