import 'package:json_annotation/json_annotation.dart';

import 'package:login_page/rest_api/listings.dart';

part 'listing_create.g.dart';

@JsonSerializable(includeIfNull: false)
class ListingRequest {
  String title;
  String description;
  int price;
  String category;
  int status;
  int quantity;
  bool condition_new;
  dynamic characteristics;
  Seller seller;

  ListingRequest({
    this.title,
    this.description,
    this.price,
    this.category,
    this.status,
    this.quantity,
    this.condition_new,
    this.characteristics,
    this.seller,
  });

  factory ListingRequest.fromJson(Map<String, dynamic> json) =>
      _$ListingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ListingRequestToJson(this);
}
