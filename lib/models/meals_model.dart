// To parse this JSON data, do
//
//     final meals = mealsFromJson(jsonString);

import 'dart:convert';

Meals mealsFromJson(String str) => Meals.fromJson(json.decode(str));

String mealsToJson(Meals data) => json.encode(data.toJson());

class Meals {
  List<Meal>? meals;

  Meals({
    this.meals,
  });

  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
    meals: json["meals"] == null ? [] : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => x.toJson())),
  };
}

class Meal {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    strMeal: json["strMeal"],
    strMealThumb: json["strMealThumb"],
    idMeal: json["idMeal"],
  );

  Map<String, dynamic> toJson() => {
    "strMeal": strMeal,
    "strMealThumb": strMealThumb,
    "idMeal": idMeal,
  };
}
