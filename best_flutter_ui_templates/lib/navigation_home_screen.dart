import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/custom_drawer/drawer_user_controller.dart';
import 'package:best_flutter_ui_templates/custom_drawer/home_drawer.dart';
import 'package:best_flutter_ui_templates/custom_drawer/plan_screen.dart';
import 'package:best_flutter_ui_templates/custom_drawer/restrictions_screen.dart';
import 'package:best_flutter_ui_templates/custom_drawer/feedback_screen.dart';
import 'package:best_flutter_ui_templates/custom_drawer/about_screen.dart';
import 'package:flutter/material.dart';

import 'fitness_app/fitness_app_home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.FeedBack;
    screenView = FitnessAppHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      if (drawerIndexdata == DrawerIndex.Plan) {
        setState(() {
          screenView = PlanScreen();
        });
      }
      if (drawerIndexdata == DrawerIndex.Restrictions) {
        setState(() {
          screenView = RestrictionsScreen();
        });
      }
      if (drawerIndexdata == DrawerIndex.FeedBack) {
        setState(() {
          screenView = FeedbackScreen();
        });
      }
      if (drawerIndexdata == DrawerIndex.Share) {
        setState(() {
          screenView = FeedbackScreen();
        });
      }
      if (drawerIndexdata == DrawerIndex.About) {
        setState(() {
          screenView = AboutScreen();
        });
      }
      if (drawerIndexdata == DrawerIndex.Settings) {
        setState(() {
          screenView = AboutScreen();
        });
      }
    }
  }
}
