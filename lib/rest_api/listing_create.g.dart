// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingRequest _$ListingRequestFromJson(Map<String, dynamic> json) {
  return ListingRequest(
    title: json['title'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    category: json['category'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$ListingRequestToJson(ListingRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'price': instance.price ?? 0,
      'category': instance.category,
      'quantity': instance.quantity,
    };
