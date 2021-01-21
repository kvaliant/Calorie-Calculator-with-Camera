import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    super.initState();
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
                        top: MediaQuery.of(context).padding.top + 75,
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
                      'Calculate your calorie with the calorie calculator and choose your diet plan \n Please choose your diet plan with deep consideration for your body’s long term health :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _buildCalculator(),
                  _buildSuggestedPlan(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
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
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Send',
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
                maxLines: 1,
                onChanged: (String txt) {},
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
                maxLines: 1,
                onChanged: (String txt) {},
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
                maxLines: 1,
                onChanged: (String txt) {},
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

  Widget _buildSuggestedPlan() {
    const double paddingSize = 10;

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
                        child: currentSelectedPlan == 0
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple)),
                    Text(
                      'Maintain weight',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      '2500 Cal/day',
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
                        child: currentSelectedPlan == 1
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple)),
                    Text(
                      'Weight gain',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      '2500 Cal/day',
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
                        child: currentSelectedPlan == 2
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple)),
                    Text(
                      'Weight loss',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      '2500 Cal/day',
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
                        child: currentSelectedPlan == 3
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple)),
                    Text(
                      'Extreme weight loss',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontSize: 16,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      '2500 Cal/day',
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
                        child: currentSelectedPlan == 3
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.deepPurple)
                            : Icon(Icons.radio_button_off,
                                color: Colors.deepPurple)),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.numberWithOptions(),
                          maxLines: 1,
                          onChanged: (String txt) {},
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

  Widget _buildChoosePlan() {}
}

int currentSelectedPlan;
genderEnum currentGender = genderEnum.male;
enum genderEnum { male, female }
unitTypeEnum currentUnitType = unitTypeEnum.Metric;
enum unitTypeEnum { Imperial, Metric }
