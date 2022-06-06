// Created By Amit Jangid on 05/06/22

import 'package:astro_tak/app/core/utils/constants/http_constants.dart';

class Category {
  int id;
  String name;
  int price;
  String description;
  List<String> suggestionsList;

  Category({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.suggestionsList,
  });

  factory Category.fromJson(Map<String, dynamic> categoryJson) => Category(
        id: categoryJson[kJsonId],
        name: categoryJson[kJsonName],
        price: categoryJson[kJsonPrice],
        description: categoryJson[kJsonDescription] ?? '',
        suggestionsList: categoryJson[kJsonSuggestions].map<String>((suggestion) => suggestion.toString()).toList(),
      );
}
