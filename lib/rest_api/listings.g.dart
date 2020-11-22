// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingsResponse _$ListingsResponseFromJson(Map<String, dynamic> json) {
  return ListingsResponse(
    count: json['count'] as int,
    next: json['next'] == null ? null : Uri.parse(json['next'] as String),
    previous:
        json['previous'] == null ? null : Uri.parse(json['previous'] as String),
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Listing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListingsResponseToJson(ListingsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next?.toString(),
      'previous': instance.previous?.toString(),
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };

Listing _$ListingFromJson(Map<String, dynamic> json) {
  return Listing(
    uuid: json['uuid'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    category: json['category'] as int,
    status: json['status'] as int,
    quantity: json['quantity'] as int,
    sold: json['sold'] as int,
    views: json['views'] as int,
    date_created: json['date_created'] == null
        ? null
        : DateTime.parse(json['date_created'] as String),
    date_expires: json['date_expires'] == null
        ? null
        : DateTime.parse(json['date_expires'] as String),
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    condition_new: json['condition_new'] as bool,
    characteristics: json['characteristics'],
    seller: json['seller'] == null
        ? null
        : Seller.fromJson(json['seller'] as Map<String, dynamic>),
    photos: (json['photos'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListingToJson(Listing instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'status': instance.status,
      'quantity': instance.quantity,
      'sold': instance.sold,
      'views': instance.views,
      'date_created': instance.date_created?.toIso8601String(),
      'date_expires': instance.date_expires?.toIso8601String(),
      'location': instance.location?.toJson(),
      'condition_new': instance.condition_new,
      'characteristics': instance.characteristics,
      'seller': instance.seller?.toJson(),
      'photos': instance.photos?.map((e) => e?.toJson())?.toList(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    id: json['id'] as int,
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

Seller _$SellerFromJson(Map<String, dynamic> json) {
  return Seller(
    uuid: json['uuid'] as String,
    date_created: json['date_created'] as String,
    full_name: json['full_name'] as String,
    about: json['about'] as String,
    online: json['online'] as bool,
    rating: json['rating'] as int,
    avatar: json['avatar'] == null ? null : Uri.parse(json['avatar'] as String),
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'date_created': instance.date_created,
      'full_name': instance.full_name,
      'about': instance.about,
      'online': instance.online,
      'rating': instance.rating,
      'avatar': instance.avatar?.toString(),
      'location': instance.location?.toJson(),
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    id: json['id'] as int,
    image: json['image'] == null ? null : Uri.parse(json['image'] as String),
    order: json['order'] as int,
    listing: json['listing'] as int,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image?.toString(),
      'order': instance.order,
      'listing': instance.listing,
    };
