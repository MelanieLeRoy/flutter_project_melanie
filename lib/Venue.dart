// To parse this JSON data, do
//
//     final venue = venueFromJson(jsonString);

import 'dart:convert';

Venue venueFromJson(String str) => Venue.fromJson(json.decode(str));

String venueToJson(Venue data) => json.encode(data.toJson());

class Venue {
  String id;
  String name;
  Location location;
  List<Category> categories;
  VenuePage venuePage;

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
        venuePage: VenuePage.fromJson(json["venuePage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "venuePage": venuePage.toJson(),
      };
}

class Category {
  String id;
  String name;
  String pluralName;
  String shortName;
  Icon icon;
  bool primary;

  Category({
    this.id,
    this.name,
    this.pluralName,
    this.shortName,
    this.icon,
    this.primary,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        pluralName: json["pluralName"],
        shortName: json["shortName"],
        icon: Icon.fromJson(json["icon"]),
        primary: json["primary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pluralName": pluralName,
        "shortName": shortName,
        "icon": icon.toJson(),
        "primary": primary,
      };
}

class Icon {
  String prefix;
  String suffix;

  Icon({
    this.prefix,
    this.suffix,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        prefix: json["prefix"],
        suffix: json["suffix"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "suffix": suffix,
      };
}

class Location {
  String address;
  String crossStreet;
  double lat;
  double lng;
  List<LabeledLatLng> labeledLatLngs;
  int distance;
  String postalCode;
  String cc;
  String city;
  String state;
  String country;
  List<String> formattedAddress;

  Location({
    this.address,
    this.crossStreet,
    this.lat,
    this.lng,
    this.labeledLatLngs,
    this.distance,
    this.postalCode,
    this.cc,
    this.city,
    this.state,
    this.country,
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        crossStreet: json["crossStreet"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        labeledLatLngs: List<LabeledLatLng>.from(
            json["labeledLatLngs"].map((x) => LabeledLatLng.fromJson(x))),
        distance: json["distance"],
        postalCode: json["postalCode"],
        cc: json["cc"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        formattedAddress:
            List<String>.from(json["formattedAddress"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "crossStreet": crossStreet,
        "lat": lat,
        "lng": lng,
        "labeledLatLngs":
            List<dynamic>.from(labeledLatLngs.map((x) => x.toJson())),
        "distance": distance,
        "postalCode": postalCode,
        "cc": cc,
        "city": city,
        "state": state,
        "country": country,
        "formattedAddress": List<dynamic>.from(formattedAddress.map((x) => x)),
      };
}

class LabeledLatLng {
  String label;
  double lat;
  double lng;

  LabeledLatLng({
    this.label,
    this.lat,
    this.lng,
  });

  factory LabeledLatLng.fromJson(Map<String, dynamic> json) => LabeledLatLng(
        label: json["label"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "lat": lat,
        "lng": lng,
      };
}

class VenuePage {
  String id;

  VenuePage({
    this.id,
  });

  factory VenuePage.fromJson(Map<String, dynamic> json) => VenuePage(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
