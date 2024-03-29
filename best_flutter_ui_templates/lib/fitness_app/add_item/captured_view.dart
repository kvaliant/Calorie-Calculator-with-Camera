import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../fintness_app_theme.dart';

class CapturedView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final PickedFile imageFile;

  const CapturedView(
      {Key key, this.animationController, this.animation, this.imageFile})
      : super(key: key);

  @override
  _CapturedViewState createState() => _CapturedViewState();
}

class _CapturedViewState extends State<CapturedView> {
  Widget _previewImage() {
    if (widget.imageFile != null) {
      return Container(
        width: 150,
        height: 100,
        child: Image.asset(
          widget.imageFile.path,
          fit: BoxFit.cover,
          width: 150,
          height: 100,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 25,
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
                        height: 25,
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
                        height: 25,
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
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48.0),
                            bottomLeft: Radius.circular(48.0),
                            bottomRight: Radius.circular(48.0),
                            topRight: Radius.circular(48.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.6),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: _previewImage(),
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
