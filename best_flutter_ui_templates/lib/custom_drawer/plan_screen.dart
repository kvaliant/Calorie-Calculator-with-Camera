import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

enum genderEnum { male, female }
enum unitTypeEnum { Imperial, Metric }
var activityList = <String>[
  'Little or no exercise',
  'Light exercise/sports 1-3 days/week',
  'Moderate exercise/sports 3-5 days/week',
  'Hard exercise/sports 6-7 days a week',
  'Very hard exercise/sports & a physical job'
];

class _PlanScreenState extends State<PlanScreen> {
  int currentSelectedPlan;
  genderEnum currentGender = genderEnum.male;
  unitTypeEnum currentUnitType = unitTypeEnum.Metric;
  int currentPlanDailyCalorie;
  int _activities = 0;
  int _age;
  int _gender;
  bool _unitType; //true = Metric
  int _height;
  int _weight;
  int _planRadio;
  int _planDailyCalorie;
  int _bmr = 0;

  _loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _age = (prefs.getInt('age') ?? null);
      _gender = (prefs.getInt('gender') ?? null);
      currentGender = _gender == 0 ? genderEnum.female : genderEnum.male;
      _unitType = (prefs.getBool('unit_type') ?? true);
      currentUnitType = _unitType ? unitTypeEnum.Metric : unitTypeEnum.Imperial;
      _height = (prefs.getInt('height') ?? null);
      _weight = (prefs.getInt('weight') ?? null);
      _activities = (prefs.getInt('activities') ?? 0);
      _planRadio = (prefs.getInt('plan_radio') ?? 0);
      currentSelectedPlan = _planRadio;
      _planDailyCalorie = (prefs.getInt('plan_daily_calorie') ?? null);
      currentPlanDailyCalorie = _planRadio == 4 ? _planDailyCalorie : null;
    });
  }

  //Incrementing counter after click
  _saveAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _gender = currentGender == genderEnum.male ? 1 : 0;
    _unitType = currentUnitType == unitTypeEnum.Metric;
    _planRadio = currentSelectedPlan;
    _planDailyCalorie = currentPlanDailyCalorie;
    if (_age != null &&
        _height != null &&
        _weight != null &&
        _bmr != 0 &&
        _planDailyCalorie != null) {
      setState(() {
        prefs.setInt('age', _age);
        prefs.setInt('gender', _gender);
        prefs.setBool('unit_type', _unitType);
        prefs.setInt('height', _height);
        prefs.setInt('weight', _weight);
        prefs.setInt('activities', _activities);
        prefs.setInt('plan_radio', _planRadio);
        prefs.setInt('plan_daily_calorie', _planDailyCalorie);
      });
    }
  }

  _calculateBMR() async {
    var activityEquationList = [1.2, 1.375, 1.55, 1.725, 1.9];
    if (_age != null && _height != null && _weight != null) {
      _bmr = ((13.397 * _weight + 4.799 * _height - 5.677 * _age) *
              activityEquationList.elementAt(_activities))
          .ceil();
      if (currentGender == genderEnum.male) {
        _bmr = (_bmr + 88.362).ceil();
      }
    } else {
      _bmr = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadAll();
      _calculateBMR();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: AppBar().preferredSize.height,
                        bottom: 0,
                        left: 16,
                        right: 16),
                    child: Text(
                      'Diet Plan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Calculate your calorie with the calorie calculator and choose your diet plan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _buildCalculator(),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Please choose your diet plan with deep consideration for your body’s long term health :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _buildSuggestedPlan(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 40,
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              _saveAll();
                              _loadAll();
                              Navigator.of(context).push(ShowOverlay());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Save',
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculator() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 0),
          child: Column(
            children: <Widget>[
              _buildAgeColumn(),
              _buildGenderColumn(),
              _buildUnitTypeColumn(),
              _buildHeightColumn(),
              _buildWeightColumn(),
              _activitiesDropDown(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgeColumn() {
    double textBoxWidth = 100;
    double textBoxHeight = 25;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              "Age",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: textBoxWidth,
            height: textBoxHeight,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    offset: const Offset(4, 4),
                    blurRadius: 8),
              ],
            ),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 1, top: 10, bottom: 0),
              child: TextField(
                controller: TextEditingController()
                  ..text = _age == null ? '' : _age.toString(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
                maxLines: 1,
                onChanged: (String txt) {
                  this._age = int.tryParse(txt);
                },
                onEditingComplete: () {
                  setState(() {
                    _calculateBMR();
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: ''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderColumn() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 0, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              "Gender",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: 25,
            child: Row(
              children: <Widget>[
                new Radio(
                  value: genderEnum.male,
                  groupValue: currentGender,
                  onChanged: (value) {
                    setState(() {
                      currentGender = value;
                      _calculateBMR();
                    });
                  },
                ),
                new Text(
                  'Male',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: genderEnum.female,
                  groupValue: currentGender,
                  onChanged: (value) {
                    setState(() {
                      currentGender = value;
                      _calculateBMR();
                    });
                  },
                ),
                new Text(
                  'Female',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitTypeColumn() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 2, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              "Unit Type",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                new TextButton(
                  onPressed: () {
                    setState(() {
                      currentUnitType = unitTypeEnum.Imperial;
                      _calculateBMR();
                    });
                  },
                  child: Text(
                    "Imperial",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: currentUnitType == unitTypeEnum.Imperial
                          ? FontWeight.w900
                          : FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
                new Text(
                  '|',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                new TextButton(
                  onPressed: () {
                    setState(() {
                      currentUnitType = unitTypeEnum.Metric;
                      _calculateBMR();
                    });
                  },
                  child: Text(
                    "Metric",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: currentUnitType == unitTypeEnum.Metric
                          ? FontWeight.w900
                          : FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeightColumn() {
    var imperialUnitHelper = [0, 0];
    double textBoxWidth = 100;
    double textBoxHeight = 25;
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              "Height",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          currentUnitType == unitTypeEnum.Metric
              ? Container(
                  width: textBoxWidth,
                  height: textBoxHeight,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          offset: const Offset(4, 4),
                          blurRadius: 8),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 1, top: 10, bottom: 0),
                    child: TextField(
                      controller: TextEditingController()
                        ..text = _height == null
                            ? '' + ' cm'
                            : _height.toString() + ' cm',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLines: 1,
                      onChanged: (String txt) {
                        this._height =
                            int.tryParse(txt.replaceAll("[^a-zA-Z]", ""));
                      },
                      onEditingComplete: () {
                        setState(() {
                          _calculateBMR();
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
                )
              : Row(
                  children: <Widget>[
                    Container(
                      width: textBoxWidth / 1.5,
                      height: textBoxHeight,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              offset: const Offset(4, 4),
                              blurRadius: 8),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 1, top: 10, bottom: 0),
                        child: TextField(
                          controller: TextEditingController()
                            ..text = _height == null
                                ? '' + ' ft'
                                : ((_height / 30.48).floor()).toString() +
                                    ' ft',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.numberWithOptions(),
                          maxLines: 1,
                          onChanged: (String txt) {
                            imperialUnitHelper[0] =
                                int.tryParse(txt.replaceAll("[^a-zA-Z]", ""));
                            _height = (imperialUnitHelper[0] * 0.0328084 +
                                    imperialUnitHelper[1] * 0.393701)
                                .round();
                          },
                          onEditingComplete: () {
                            setState(() {
                              _calculateBMR();
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
                              border: InputBorder.none, hintText: 'a'),
                        ),
                      ),
                    ),
                    Container(
                      width: textBoxWidth / 1.5,
                      height: textBoxHeight,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              offset: const Offset(4, 4),
                              blurRadius: 8),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 1, top: 10, bottom: 0),
                        child: TextField(
                          controller: TextEditingController()
                            ..text = _height == null
                                ? '' + ' in'
                                : ((((_height % 30.48).floor()) / 2.54).round())
                                        .toString() +
                                    ' in',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.numberWithOptions(),
                          maxLines: 1,
                          onChanged: (String txt) {
                            this._height =
                                int.tryParse(txt.replaceAll("[^a-zA-Z]", ""));
                          },
                          onEditingComplete: () {
                            setState(() {
                              _calculateBMR();
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
                              border: InputBorder.none, hintText: 'a'),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget _buildWeightColumn() {
    double textBoxWidth = 100;
    double textBoxHeight = 25;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              "Weight",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: textBoxWidth,
            height: textBoxHeight,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    offset: const Offset(4, 4),
                    blurRadius: 8),
              ],
            ),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 1, top: 10, bottom: 0),
              child: TextField(
                controller: TextEditingController()
                  ..text = currentUnitType == unitTypeEnum.Metric
                      ? _weight == null
                          ? '' + ' kg'
                          : _weight.toString() + ' kg'
                      : _weight == null
                          ? '' + ' lb'
                          : (_weight * 2.20462).round().toString() + ' lb',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
                maxLines: 1,
                onChanged: (String txt) {
                  _weight = currentUnitType == unitTypeEnum.Metric
                      ? int.tryParse(txt.replaceAll("[^a-zA-Z]", ""))
                      : (int.tryParse(txt.replaceAll("[^a-zA-Z]", "")) *
                              0.453592)
                          .round();
                },
                onEditingComplete: () {
                  setState(() {
                    _calculateBMR();
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: ''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activitiesDropDown() {
    return Container(
      child: DropdownButton<String>(
        value: activityList.elementAt(_activities),
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String txt) {
          setState(() {
            _activities = activityList.indexOf(txt);
            _calculateBMR();
          });
        },
        items: activityList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSuggestedPlan() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 50),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.scale(
                      scale: .8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentSelectedPlan = 0;
                            _planDailyCalorie = 0123;
                            _calculateBMR();
                          });
                        },
                        child: currentSelectedPlan == 0
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple),
                      ),
                    ),
                    Text(
                      'Maintain weight',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      _bmr.toString() + ' KCal/day',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.scale(
                      scale: .8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentSelectedPlan = 1;
                            _calculateBMR();
                            _planDailyCalorie =
                                _bmr == 0 ? '' : (_bmr * 0.8).ceil();
                          });
                        },
                        child: currentSelectedPlan == 1
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple),
                      ),
                    ),
                    Text(
                      'Weight loss',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      (_bmr * 0.8).ceil().toString() + ' KCal/day',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.scale(
                      scale: .8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentSelectedPlan = 2;
                            _calculateBMR();
                            _planDailyCalorie = (_bmr * 0.61).ceil();
                          });
                        },
                        child: currentSelectedPlan == 2
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple),
                      ),
                    ),
                    Text(
                      'Extreme loss',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      (_bmr * 0.61).ceil().toString() + ' KCal/day',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.scale(
                      scale: .8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentSelectedPlan = 3;
                            _calculateBMR();
                            _planDailyCalorie = (_bmr * 1.2).ceil();
                          });
                        },
                        child: currentSelectedPlan == 3
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple),
                      ),
                    ),
                    Text(
                      'Weight Gain',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      (_bmr * 1.2).ceil().toString() + ' KCal/day',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.scale(
                      scale: .8,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentSelectedPlan = 4;
                          });
                        },
                        child: currentSelectedPlan == 4
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple),
                      ),
                    ),
                    Text(
                      'Custom',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Container(
                      width: 105,
                      height: 25,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              offset: const Offset(4, 4),
                              blurRadius: 8),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 1, top: 10, bottom: 0),
                        child: TextField(
                          controller: TextEditingController()
                            ..text = currentPlanDailyCalorie == null
                                ? ''
                                : currentPlanDailyCalorie.toString(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.numberWithOptions(),
                          maxLines: 1,
                          onChanged: (String txt) {
                            currentPlanDailyCalorie = int.parse(txt);
                          },
                          onEditingComplete: () {
                            setState(() {
                              currentSelectedPlan = 4;
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  ShowOverlay({
    Key key,
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
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Data Sucessfully Saved!',
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppTheme.white,
            ),
          ),
          Text(
            'Press again to continue',
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: AppTheme.white,
            ),
          ),
        ],
      ),
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
