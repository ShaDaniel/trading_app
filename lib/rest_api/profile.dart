import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

// См. listing_create.dart

@JsonSerializable()
class ProfileInfo {
  String uuid;
  DateTime date_created;
  String full_name;
  String about;
  bool online;
  int rating;
  Uri avatar;
  int location;

  ProfileInfo({
    this.uuid,
    this.date_created,
    this.full_name,
    this.about,
    this.online,
    this.rating,
    this.avatar,
    this.location,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}
