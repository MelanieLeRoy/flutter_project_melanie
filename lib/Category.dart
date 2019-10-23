import 'dart:convert';

import 'Venue.dart';

class JsonResponseCategories {
  Meta meta;
  Categories categories;

  JsonResponseCategories({
    this.meta,
    this.categories,
  });

  factory JsonResponseCategories.fromJson(Map<String, dynamic> json) =>
      JsonResponseCategories(
        meta: Meta.fromJson(json["meta"]),
        categories: Categories.fromJson(json["response"]),
      );
}

class Categories {
  List<Category> categories;

  Categories({
    this.categories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  List<Category> getCategories() {
    return this.categories;
  }
}

class Category {
  String id;
  String pluralName;
  String shortName;
  IconV icon;

  Category({
    this.id,
    this.pluralName,
    this.shortName,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        pluralName: json["pluralName"],
        shortName: json["shortName"],
        icon: IconV.fromJson(json["icon"]),
      );
}
