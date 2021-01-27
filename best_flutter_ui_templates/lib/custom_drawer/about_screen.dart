import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _jsonContent;
  @override
  void initState() {
    super.initState();
    _loadFoodHistoryJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 75,
                          left: 16,
                          right: 16),
                      child: Icon(Icons.info)
                      //Image.asset('assets/images/feedbackImage.png'),
                      ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _jsonContent,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _loadFoodHistoryJson() async {
    String jsonString = await rootBundle.loadString("assets/food_history.json");
    final jsonData = json.decode(jsonString);
    FoodHistory foodHistory = FoodHistory.fromJson(jsonData);
    setState(() {
      _jsonContent = foodHistory.toString();
    });
  }
}

class FoodHistory {
  Map<String, Food> food;
  FoodHistory({this.food});
  @override
  String toString() {
    return 'FoodHistory{food: $food}';
  }

  factory FoodHistory.fromJson(Map<String, dynamic> json) {
    var mapFood = json["food"] as Map;
    var mapFoodContent = mapFood.map((key, value) {
      return MapEntry<String, Food>(key, Food.fromJson(value));
    });
    return FoodHistory(
      food: mapFoodContent,
    );
  }
}

class Food {
  String id;
  String name;
  String calorie;
  String timeStamp;
  Food({this.id, this.name, this.calorie, this.timeStamp});
  @override
  String toString() {
    return 'Food{id: $id, name: $name, calorie: $calorie, timeStamp: $timeStamp}';
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        id: json["id"],
        name: json["name"],
        calorie: json["calorie"],
        timeStamp: json["timeStamp"]);
  }
}
