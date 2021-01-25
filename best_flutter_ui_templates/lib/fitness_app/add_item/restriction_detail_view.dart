import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import '../fintness_app_theme.dart';

class RestrictionDetailView extends StatelessWidget {
  const RestrictionDetailView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 100, bottom: 0),
        child: Column(
          children: <Widget>[
            _buildTitleView(),
            _buildRestrictionView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 12,
              width: 450,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  FitnessAppTheme.nearlyDarkBlue,
                  HexColor("#6F56E8")
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
          ),
          Container(
            width: 450,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 0),
              child: Text(
                'Hamburger',
                textAlign: TextAlign.center,
                style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                        color: FitnessAppTheme.white,
                        offset: Offset(1, 1),
                        blurRadius: 10.0),
                  ],
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  letterSpacing: 1.2,
                  color: FitnessAppTheme.darkerText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestrictionView() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          height: 250,
          width: 450,
          decoration: BoxDecoration(
            color: AppTheme.nearlyWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.grey.withOpacity(0.6),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'The',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '*Different recipie might contain different ingredient',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
