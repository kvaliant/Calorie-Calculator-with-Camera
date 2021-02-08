import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/foods_list_data.dart';
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
  List<String> currentMatch;

  @override
  void initState() {
    setState(() {
      currentFood = widget.foodData;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(RestrictionDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
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
          height: 225,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: FutureBuilder<String>(
                  future: _loadAll(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        snapshot.data.toString() == 'no'
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Center(
                                  child: Text(
                                    'This food did not contain any of the food restrictions and alergies classified by this app*',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Center(
                                  child: Text(
                                    'This food may be' +
                                        snapshot.data.toString() +
                                        '*',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                  child: Text(
                    '*Different recipie might contain different ingredient',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
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

  Future<String> _loadAll() async {
    int index = 0;
    currentMatch = [];
    String currentMatchText = '';
    if ('true' == currentFood.restrictions.halal.toString())
      currentMatch.add(' Non Halal');
    if ('true' == currentFood.restrictions.vegan.toString())
      currentMatch.add(' Non Vegan');
    if ('true' == currentFood.restrictions.hinduism.toString())
      currentMatch.add(' Non Hinduism');
    if ('true' == currentFood.restrictions.prawn.toString())
      currentMatch.add(' Contain Prawn');
    if ('true' == currentFood.restrictions.clam.toString())
      currentMatch.add(' Contain Clam');
    if ('true' == currentFood.restrictions.seafood.toString())
      currentMatch.add(' Contain Seafood');
    if ('true' == currentFood.restrictions.nut.toString())
      currentMatch.add(' Contain Nut');
    if ('true' == currentFood.restrictions.gluten.toString())
      currentMatch.add(' Contain Gluten');
    if ('true' == currentFood.restrictions.lactose.toString())
      currentMatch.add(' Contain Lactose');
    if (currentMatch.length > 0) {
      currentMatch.forEach((element) {
        if (index == currentMatch.length - 1) {
          currentMatchText = currentMatchText + element;
        } else {
          currentMatchText = currentMatchText + element + ',';
        }
      });
    } else {
      currentMatchText = 'no';
    }
    return currentMatchText;
  }
}
