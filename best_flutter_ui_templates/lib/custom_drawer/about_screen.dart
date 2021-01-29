import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';

/*
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:best_flutter_ui_templates/fitness_app/food_history_controller.dart';
*/
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  //String _jsonContent;
  @override
  void initState() {
    super.initState();
    //_loadFoodHistoryJson();
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
                      'We Build Apps :)',
                      //_jsonContent,
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
/*
  Future _loadFoodHistoryJson() async {
    String jsonString = await rootBundle.loadString("assets/food_history.json");
    final jsonData = json.decode(jsonString);
    FoodHistory foodHistory = FoodHistory.fromJson(jsonData);
    setState(() {
      _jsonContent = foodHistory.toString();
    });
  }
*/
}
