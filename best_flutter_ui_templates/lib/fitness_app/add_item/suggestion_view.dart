import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SuggestionView extends StatefulWidget {
  const SuggestionView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.addClick,
      this.suggestionString})
      : super(key: key);

  final Function addClick;
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final String suggestionString;

  @override
  _SuggestionViewState createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> suggestionListData;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    getSuggestionListData();
    super.initState();
  }

  @override
  void didUpdateWidget(SuggestionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      getSuggestionListData();
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 0, right: 16, left: 16),
                itemCount: suggestionListData.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final int count = suggestionListData.length > 10
                      ? 10
                      : suggestionListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return Container(
                    child: InkWell(
                      onTap: () {
                        widget.addClick(suggestionListData[index]);
                      },
                      child: SuggestionItem(
                        suggestionListData: suggestionListData[index],
                        animation: animation,
                        animationController: animationController,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void getSuggestionListData() {
    /*
    var jsonString = widget.suggestionString.replaceFirst("200", "");
    var parsedJson = jsonDecode(jsonString);
    suggestionListData = [];
    FoodsListData.foodDatabase.forEach((element) {
      if (parsedJson.toString().contains(element.foodName)) {
        suggestionListData.add(element.foodName);
      }
    });
    */
    var jsonString = widget.suggestionString.replaceFirst("200", "");
    var jsonData = jsonDecode(jsonString);
    var predictionsStringList = jsonData['predictions'] as List;
    //List<Predictions> predictionsList = <Predictions>[];
    //suggestionListData = [predictionsStringList[1].toString()];
    suggestionListData = [];
    predictionsStringList.forEach((element) {
      String jsonString2 = element.toString();
      jsonString2 = jsonString2.replaceAll("probability: ", '"probability": "');
      jsonString2 = jsonString2.replaceAll(", tagId: ", '", "tagId": "');
      jsonString2 = jsonString2.replaceAll(", tagName: ", '", "tagName": "');
      jsonString2 = jsonString2.replaceAll("}", '"}');
      var jsonData2 = jsonDecode(jsonString2);
      double probability = double.tryParse(jsonData2['probability']);
      //String tagId = jsonData2['tagId'].toString();
      String tagName = jsonData2['tagName'].toString();
      if (probability > 0) suggestionListData.add(tagName.toString());
    });
  }
}

class SuggestionItem extends StatelessWidget {
  const SuggestionItem(
      {Key key,
      this.suggestionListData,
      this.animationController,
      this.animation})
      : super(key: key);

  final suggestionListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 0, right: 0, bottom: 8),
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyDarkBlue,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.8),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12, left: 0, right: 0, bottom: 12),
                        child: Text(
                          suggestionListData,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: FitnessAppTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
