
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opine_project/models/meals_model.dart';
import 'package:opine_project/view/fooditems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/categoty_model.dart';



class Categories extends StatefulWidget {
  //const Categories({required Key key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Category? category;

  Future<String>getAccessToken()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString("token") ?? "";
  }

  Future<void>getApi()async{
    String api="http://www.themealdb.com/api/json/v1/1/categories.php";
    String accessToken=await getAccessToken();
    var response=await http.get(Uri.parse(api));
    if(response.statusCode==200){
      final Map<String,dynamic>responseData=json.decode(response.body);
      print(response.statusCode);
      print(responseData);


    setState(() {
      category=Category.fromJson(responseData);
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
        title: Text('Food Items'),
      ),
      body: category == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: category!.categories!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Food_items(
                      categoriess: category!.categories![index].strCategory ?? "",
                    ),
                  ),
                );
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category?.categories?[index].strCategory ?? "",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(category?.categories?[index].strCategoryDescription ?? ""),
                    SizedBox(height: 10,),
                    CachedNetworkImage(
                      imageUrl: category?.categories?[index].strCategoryThumb ?? "",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

}
}

