import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/fintness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/meals_list_data.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../main.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<FoodObject> foodList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    asyncMethod();
    super.initState();
  }

  Future<bool> asyncMethod() async {
    foodList = await _readHistory();
    return true;
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
              child: foodList == null
                  ? Container()
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, right: 16, left: 16),
                      itemCount: foodList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final int count =
                            foodList.length > 10 ? 10 : foodList.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval(
                                        (1 / count ?? 1) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                        animationController.forward();
                        return MealsView(
                          foodList: foodList[index],
                          animation: animation,
                          animationController: animationController,
                        );
                      },
                    ),

              /* foodList.length == 0
                  ? Text('')
                  : FutureBuilder(
                      future: _readHistory(),
                      builder: (context, listFood) {
                        if (!listFood.hasData || foodList == null) {
                          return Container();
                        } else {
                          return ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, right: 16, left: 16),
                            itemCount: foodList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                                  foodList.length > 10 ? 10 : foodList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval(
                                              (1 / count ?? 1) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return MealsView(
                                foodList: foodList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          );
                        }
                      },
                    ),*/
            ),
          ),
        );
      },
    );
  }

  int keyPointer; //id, name, cal, timeStamp
  Future<List<FoodObject>> _readHistory() async {
    keyPointer = 0;
    List<FoodObject> foodList;
    foodList = <FoodObject>[];
    int index = 0;
    int id;
    String name;
    int calorie;
    DateTime timeStamp;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _history = (prefs.getStringList('history') ?? null);
    if (_history != null) {
      do {
        String text = _history.elementAt(index);
        keyPointer == 0
            ? id = int.parse(text) //int.tryParse(text)
            : keyPointer == 1
                ? name = text
                : keyPointer == 2
                    ? calorie = int.parse(text) //int.tryParse(text)
                    : timeStamp = DateTime.parse("1969-07-20 20:18:04Z");
        keyPointer++;
        if (keyPointer == 4) {
          keyPointer = 0;
          FoodObject makeFood = FoodObject(
              id: id, name: name, calorie: calorie, timeStamp: timeStamp);
          foodList.add(makeFood);
        }
        FoodObject makeFood = FoodObject(
            id: id, name: name, calorie: calorie, timeStamp: timeStamp);
        foodList.add(makeFood);
        index++;
      } while (index < _history.length);
    }
    return foodList;
  }
}

class MealsView extends StatelessWidget {
  const MealsView(
      {Key key, this.foodList, this.animationController, this.animation})
      : super(key: key);

  final FoodObject foodList;
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
                        top: 16, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.dark_grey.withOpacity(0.6),
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
                            top: 16, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                foodList.name + '\n',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                            ),
                            Text(
                              foodList.timeStamp.hour.toString() +
                                  ':' +
                                  foodList.timeStamp.minute.toString(),
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            foodList.calorie != 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        foodList.calorie.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Text(
                                          'cal',
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 0.2,
                                            color: FitnessAppTheme.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: FitnessAppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: FitnessAppTheme.nearlyBlack
                                                .withOpacity(0.4),
                                            offset: Offset(8.0, 8.0),
                                            blurRadius: 8.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(mealsListData.imagePath),
                    ),
                  )
                  */
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FoodObject {
  FoodObject({
    this.id = 0,
    this.name = '',
    this.calorie = 0,
    this.timeStamp,
  });

  int id;
  String name;
  int calorie;
  DateTime timeStamp;
}
