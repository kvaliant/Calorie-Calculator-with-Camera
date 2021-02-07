import 'package:best_flutter_ui_templates/fitness_app/add_item/nutrition_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/add_item/choose_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/add_item/scan_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/traning/training_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fintness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

PickedFile _imageFile;

void setFunctionImageFile(PickedFile tempImageFile) {
  _imageFile = tempImageFile;
}

Widget tabBody = Container(
  color: FitnessAppTheme.background,
);

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: (middleButtonEnum currentMiddleButton) {
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                switch (currentMiddleButton) {
                  case middleButtonEnum.add:
                    _imageFile = null;
                    tabBody = ScanScreen(
                        animationController: animationController,
                        addClick: (String txt) {
                          setState(() {
                            tabBody = ChooseScreen(
                              animationController: animationController,
                              imageFile: _imageFile,
                              suggestionString: txt,
                              addClick: (String txt2) {
                                setState(() {
                                  tabBody = NutritionScreen(
                                    animationController: animationController,
                                    foodName: txt2,
                                    imageFile: _imageFile,
                                  );
                                });
                              },
                            );
                          });
                        });
                    break;
                  case middleButtonEnum.capture:
                    break;
                  case middleButtonEnum.retry:
                    _imageFile = null;
                    tabBody = ScanScreen(
                        animationController: animationController,
                        addClick: (String txt) {
                          setState(() {
                            animationController.reverse().then<dynamic>((data) {
                              if (!mounted) {
                                return;
                              }
                              tabBody = ChooseScreen(
                                animationController: animationController,
                                imageFile: _imageFile,
                                suggestionString: txt,
                                addClick: (String txt2) {
                                  animationController
                                      .reverse()
                                      .then<dynamic>((data) {
                                    if (!mounted) {
                                      return;
                                    }
                                    setState(() {
                                      tabBody = NutritionScreen(
                                        animationController:
                                            animationController,
                                        foodName: txt2,
                                        imageFile: _imageFile,
                                      );
                                    });
                                  });
                                },
                              );
                            });
                          });
                        });
                    break;
                  default:
                }
              });
            });
          },
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              _imageFile = null;
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
