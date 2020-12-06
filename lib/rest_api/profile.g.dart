// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) {
  return ProfileInfo(
    uuid: json['uuid'] as String,
    date_created: json['date_created'] == null
        ? null
        : DateTime.parse(json['date_created'] as String),
    full_name: json['full_name'] as String,
    about: json['about'] as String,
    online: json['online'] as bool,
    rating: json['rating'] as int,
    avatar: json['avatar'] == null ? null : Uri.parse(json['avatar'] as String),
    location: json['location'] as int,
  );
}

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'date_created': instance.date_created?.toIso8601String(),
      'full_name': instance.full_name,
      'about': instance.about,
      'online': instance.online,
      'rating': instance.rating,
      'avatar': instance.avatar?.toString(),
      'location': instance.location,
    };
