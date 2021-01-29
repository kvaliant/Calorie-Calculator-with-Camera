import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/foods_list_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../fintness_app_theme.dart';

class RestrictionDetailView extends StatefulWidget {
  const RestrictionDetailView({
    Key key,
    this.foodData,
  }) : super(key: key);

  final FoodsListData foodData;
  @override
  _RestrictionDetailViewState createState() => _RestrictionDetailViewState();
}

class _RestrictionDetailViewState extends State<RestrictionDetailView> {
  FoodsListData currentFood;
  List<String> _restrictions;
  List<String> currentMatch;

  @override
  void initState() {
    setState(() {
      currentFood = widget.foodData;
      _loadAll();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(RestrictionDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _loadAll();
      currentFood = widget.foodData;
    });
  }

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
                currentFood == null ? '' : currentFood.foodName,
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

  bool _getMatchingRestrictions() {
    int index = 0;
    currentMatch = [];
    _restrictions.forEach((element) {
      switch (index) {
        case 0:
          if (element == 'true' &&
              element == currentFood.restrictions.halal.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 1:
          if (element == 'true' &&
              element == currentFood.restrictions.vegan.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 2:
          if (element == 'true' &&
              element == currentFood.restrictions.hinduism.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 3:
          if (element == 'true' &&
              element == currentFood.restrictions.prawn.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 4:
          if (element == 'true' &&
              element == currentFood.restrictions.clam.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 5:
          if (element == 'true' &&
              element == currentFood.restrictions.seafood.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 6:
          if (element == 'true' &&
              element == currentFood.restrictions.nut.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 7:
          if (element == 'true' &&
              element == currentFood.restrictions.gluten.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
        case 8:
          if (element == 'true' &&
              element == currentFood.restrictions.lactose.toString())
            currentMatch.add('true');
          else
            currentMatch.add('false');
          break;
      }
      index++;
    });
    if (currentMatch.length > 0) {
      return true;
    }
    return false;
  }

  _loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _restrictions = (prefs.getStringList('restrictions') ?? null);
    _restrictions = _restrictions == null ? [] : _restrictions;
  }
}
