
import 'dart:convert';

import 'Category.dart';

JsonResponseVenues jsonResponseVenuesFromJson(String str) =>
    JsonResponseVenues.fromJson(json.decode(str));


class JsonResponseVenues {
  Meta meta;
  Venues venues;

  JsonResponseVenues({
    this.meta,
    this.venues,
  });

  factory JsonResponseVenues.fromJson(Map<String, dynamic> json) =>
      JsonResponseVenues(
        meta: Meta.fromJson(json["meta"]),
        venues: Venues.fromJson(json["response"]),
      );

}

class Meta {
  int code;
  String requestId;

  Meta({
    this.code,
    this.requestId,
  });

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(
        code: json["code"],
        requestId: json["requestId"],
      );

}

class Venues {
  List<Venue> venues;

  Venues({
    this.venues,
  });

  factory Venues.fromJson(Map<String, dynamic> json) =>
      Venues(
        venues: List<Venue>.from(json["venues"].map((x) => Venue.fromJson(x))),
      );

  List<Venue> getVenues() {
    return this.venues;
  }

}

class Venue {
  String id;
  String name;
  Location location;
  List<Category> categories;
  VenuePage venuePage;
  IconV icon;

  Venue({
    this.id,
    this.name,
    this.location,
    this.categories,
    this.venuePage,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    id: json["id"],
    name: json["name"],
    location: Location.fromJson(json["location"]),
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
    venuePage: json["venuePage"] == null ? null : VenuePage.fromJson(
        json["venuePage"]),
  );



}


class IconV {
  String prefix;
  String suffix;

  IconV({
    this.prefix,
    this.suffix,
  });

  factory IconV.fromJson(Map<String, dynamic> json) =>
      IconV(
    prefix: json["prefix"],
    suffix: json["suffix"],
  );


}



class Location {
  double lat;
  double lng;
  List<String> formattedAddress;

  Location({
    this.lat,
    this.lng,
    this.formattedAddress
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    formattedAddress: List<String>.from(json["formattedAddress"].map((x) => x)),
  );

}

class VenuePage {
  String id;

  VenuePage({
    this.id,
  });

  factory VenuePage.fromJson(Map<String, dynamic> json) => VenuePage(
    id: json["id"],
  );

}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
