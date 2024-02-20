import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opine_project/models/meals_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Food_items extends StatefulWidget {
  final String categoriess;
  const Food_items({Key? key, required this.categoriess});

  @override
  State<Food_items> createState() => _Food_itemsState();
}

class _Food_itemsState extends State<Food_items> {
  Meals? meal;

  Future<String> getAccessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token") ?? "";
  }

  Future<void> getApi() async {
    String api = "http://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";
    String accessToken = await getAccessToken();
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.statusCode);
      print(responseData);

      setState(() {
       meal=Meals.fromJson(responseData);
      });
    }
  }

  @override
  void initState() {
    getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: meal == null
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: meal?.meals?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    meal?.meals?[index].strMeal ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    // Add maxLines to limit the number of lines
                    maxLines: 2,
                    // Add overflow property to handle text overflow
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: CachedNetworkImage(
                    imageUrl: meal?.meals?[index].strMealThumb ?? "",
                    // Add fit property to adjust how the image fits into the space
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
