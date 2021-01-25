import 'package:json_annotation/json_annotation.dart';

import 'package:login_page/rest_api/listings.dart';

part 'listing_create.g.dart';

// Дополнительная библиотека, которая ещё и лишние файлы генерирует? Зачем?
// Есть же встроенный json

@JsonSerializable(includeIfNull: false)
class ListingRequest {
  String title;
  String description;
  int price;
  String category;
  int status;
  int quantity;
  bool condition_new; // Из-за этого имя переменной не в правильном формате.
  dynamic characteristics;
  Seller seller;

  // Этот конструктор нужен только для библиотеки.
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

  // И в фабрике здесь тоже никакого смысла нет.
  factory ListingRequest.fromJson(Map<String, dynamic> json) =>
      _$ListingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ListingRequestToJson(this);

  // Можно было бы оставить один конструктор со списком инициализации и всё.
}
