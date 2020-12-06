// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    uuid: json['uuid'] as String,
    email: json['email'] as String,
    is_email_verified: json['is_email_verified'] as bool,
    date_joined: json['date_joined'] == null
        ? null
        : DateTime.parse(json['date_joined'] as String),
    balance: json['balance'] as int,
    error: json['error'] as String,
    profile: json['profile'] == null
        ? null
        : ProfileInfo.fromJson(json['profile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'email': instance.email,
      'is_email_verified': instance.is_email_verified,
      'date_joined': instance.date_joined?.toIso8601String(),
      'balance': instance.balance,
      'error': instance.error,
      'profile': instance.profile?.toJson(),
    };
