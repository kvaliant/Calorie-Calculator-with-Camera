import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/fitness_app/image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../fintness_app_theme.dart';

class CameraView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Function addClick;

  const CameraView(
      {Key key, this.animationController, this.animation, this.addClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 75),
                      ),
                      Container(
                        height: 50,
                        width: 450,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(68.0),
                              bottomLeft: Radius.circular(68.0),
                              bottomRight: Radius.circular(68.0),
                              topRight: Radius.circular(68.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.6),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 450,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                FitnessAppTheme.nearlyDarkBlue,
                                HexColor("#6F56E8")
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(68.0),
                              bottomLeft: Radius.circular(68.0),
                              bottomRight: Radius.circular(68.0),
                              topRight: Radius.circular(68.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.6),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 450,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(68.0),
                              bottomLeft: Radius.circular(68.0),
                              bottomRight: Radius.circular(68.0),
                              topRight: Radius.circular(68.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.6),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: 350,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: CameraModule(
                        addClick: (String txt) {
                          addClick(txt);
                        },
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
