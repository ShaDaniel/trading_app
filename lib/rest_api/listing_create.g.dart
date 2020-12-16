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
    status: json['status'] as int,
    quantity: json['quantity'] as int,
    condition_new: json['condition_new'] as bool,
    characteristics: json['characteristics'],
    seller: json['seller'] == null
        ? null
        : Seller.fromJson(json['seller'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ListingRequestToJson(ListingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('price', instance.price);
  writeNotNull('category', instance.category);
  writeNotNull('status', instance.status);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('condition_new', instance.condition_new);
  writeNotNull('characteristics', instance.characteristics);
  writeNotNull('seller', instance.seller);
  return val;
}
