import 'package:json_annotation/json_annotation.dart';

part 'listing_create.g.dart';

@JsonSerializable()
class ListingRequest {
  String title;
  String description;
  int price;
  String category;
  int quantity;

  ListingRequest({
    this.title,
    this.description,
    this.price,
    this.category,
    this.quantity,
  });

  factory ListingRequest.fromJson(Map<String, dynamic> json) =>
      _$ListingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ListingRequestToJson(this);
}
