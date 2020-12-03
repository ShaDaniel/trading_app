import 'package:json_annotation/json_annotation.dart';

part 'listings.g.dart';

@JsonSerializable(explicitToJson: true)
class ListingsResponse {
  int count;
  Uri next;
  Uri previous;
  List<Listing> results;

  ListingsResponse({this.count, this.next, this.previous, this.results});

  factory ListingsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListingsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Listing {
  String uuid;
  String title;
  String description;
  int price;
  String category;
  int status;
  int quantity;
  int sold;
  int views;
  DateTime date_created;
  DateTime date_expires;
  Location location;
  bool condition_new;
  Object characteristics;
  Seller seller;
  List<Photo> photos;

  Listing({
    this.uuid,
    this.title,
    this.description,
    this.price,
    this.category,
    this.status,
    this.quantity,
    this.sold,
    this.views,
    this.date_created,
    this.date_expires,
    this.location,
    this.condition_new,
    this.characteristics,
    this.seller,
    this.photos,
  });

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
  Map<String, dynamic> toJson() => _$ListingToJson(this);
}

@JsonSerializable()
class Location {
  int id;
  double longitude;
  double latitude;

  Location({
    this.id,
    this.longitude,
    this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seller {
  String uuid;
  String date_created;
  String full_name;
  String about;
  bool online;
  int rating;
  Uri avatar;
  Location location;

  Seller({
    this.uuid,
    this.date_created,
    this.full_name,
    this.about,
    this.online,
    this.rating,
    this.avatar,
    this.location,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);
}

@JsonSerializable()
class Photo {
  int id;
  Uri image;
  int order;
  int listing;

  Photo({
    this.id,
    this.image,
    this.order,
    this.listing,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
