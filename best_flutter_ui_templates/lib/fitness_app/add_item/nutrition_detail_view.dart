import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/fitness_app/add_item/restriction_detail_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/foods_list_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../fintness_app_theme.dart';

class NutritionDetailView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final FoodsListData foodData;

  const NutritionDetailView(
      {Key key, this.animationController, this.animation, this.foodData})
      : super(key: key);
  @override
  _NutritionDetailViewState createState() => _NutritionDetailViewState();
}

FoodsListData currentFood;

class _NutritionDetailViewState extends State<NutritionDetailView> {
  double _currentServing = 0.0;
  List<String> _restrictions;
  List<String> currentMatch = [];
  String currentMatchText = '';

  @override
  void initState() {
    setState(() {
      currentFood = widget.foodData;
    });

    super.initState();
  }

  @override
  void didUpdateWidget(NutritionDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      currentFood = widget.foodData;
    });
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
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 0),
              child: Column(
                children: <Widget>[
                  _buildTitleView(),
                  _buildRestrictionView(context),
                  _buildNutritionView(),
                  _buildAddView(),
                ],
              ),
            ),
          ),
        );
      },
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

  Widget _buildRestrictionView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
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
                              child: Text(
                                'This food did not contain any of your food restrictions and alergies*',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'This food may be' +
                                    snapshot.data.toString() +
                                    '*',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(4, 4),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(ShowOverlay());
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
    );
  }

  Widget _buildNutritionView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Calorie :',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 75),
                    child: Text(
                      currentFood == null
                          ? ''
                          : currentFood.calorie.toString() + ' Calorie',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 25),
                    child: Text(
                      'Serving Size :',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 75),
                    child: Text(
                      currentFood == null ? '' : currentFood.servingSize,
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
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
                'How many serving did you eat ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentServing = _currentServing - 1.0 < 0
                                    ? 0.0
                                    : _currentServing - 0.25;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '-¼',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentServing = _currentServing - 1.0 < 0
                                    ? 0.0
                                    : _currentServing - 0.5;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '-½',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentServing = _currentServing - 1.0 < 0
                                    ? 0.0
                                    : _currentServing - 1.0;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '-1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(0.0),
                          topRight: Radius.circular(0.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            offset: const Offset(1, 3),
                            blurRadius: 8),
                      ],
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 1, top: 10, bottom: 0),
                    child: TextField(
                      controller: TextEditingController()
                        ..text = _currentServing == null
                            ? '0'
                            : _currentServing.toString(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLines: 1,
                      onChanged: (String txt) {
                        _currentServing = double.parse(txt);
                      },
                      onEditingComplete: () {
                        _currentServing =
                            _currentServing < 0 ? 0.0 : _currentServing;
                        setState(() {
                          _currentServing = _currentServing;
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: ''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentServing = _currentServing + 1.0;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '+1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentServing = _currentServing + 0.5;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '+½',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentServing = _currentServing + 0.25;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '+¼',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Calorie : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentFood == null
                      ? Container()
                      : Text(
                          currentFood.calorie.toString() +
                              ' * ' +
                              _currentServing.toString() +
                              ' = ' +
                              (_currentServing * currentFood.calorie)
                                  .ceil()
                                  .toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 8.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (_currentServing != 0 && currentFood != null)
                        _saveAll();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Add to daily calorie',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _history = (prefs.getStringList('history') ?? null);
    int id = int.tryParse(_history.elementAt(_history.length - 4));
    id++;
    _history.add(id.toString());
    _history.add(currentFood.foodName);
    int _totalCalorie = (_currentServing * currentFood.calorie).ceil();
    _history.add(_totalCalorie.toString());
    _history.add(DateTime.now().toString());
    prefs.setStringList('history', _history);
  }

  Future<String> _loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _restrictions = (prefs.getStringList('restrictionsActiveList') ?? null);
    _restrictions = _restrictions == null ? [] : _restrictions;
    int index = 0;
    currentMatch = [];
    currentMatchText = '';
    _restrictions.forEach((element) {
      switch (index) {
        case 0:
          if (element == 'true' &&
              element == currentFood.restrictions.halal.toString())
            currentMatch.add(' Non Halal');
          break;
        case 1:
          if (element == 'true' &&
              element == currentFood.restrictions.vegan.toString())
            currentMatch.add(' Non Vegan');
          break;
        case 2:
          if (element == 'true' &&
              element == currentFood.restrictions.hinduism.toString())
            currentMatch.add(' Non Hinduism');
          break;
        case 3:
          if (element == 'true' &&
              element == currentFood.restrictions.prawn.toString())
            currentMatch.add(' Contain Prawn');
          break;
        case 4:
          if (element == 'true' &&
              element == currentFood.restrictions.clam.toString())
            currentMatch.add(' Contain Clam');
          break;
        case 5:
          if (element == 'true' &&
              element == currentFood.restrictions.seafood.toString())
            currentMatch.add(' Contain Seafood');
          break;
        case 6:
          if (element == 'true' &&
              element == currentFood.restrictions.nut.toString())
            currentMatch.add(' Contain Nut');
          break;
        case 7:
          if (element == 'true' &&
              element == currentFood.restrictions.gluten.toString())
            currentMatch.add(' Contain Gluten');
          break;
        case 8:
          if (element == 'true' &&
              element == currentFood.restrictions.lactose.toString())
            currentMatch.add(' Contain Lactose');
          break;
      }
      index++;
    });
    index = 0;
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

class ShowOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  final AnimationController animationController;

  ShowOverlay({
    Key key,
    this.animationController,
  });

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: RestrictionDetailView(foodData: currentFood),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
