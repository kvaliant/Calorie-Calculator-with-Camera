import 'package:best_flutter_ui_templates/fitness_app/fintness_app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

int _totalCalorie;
int _nextTotalCalorie;
int _prevTotalCalorie;
int _planDailyCalorie;

class MediterranesnDietView extends StatefulWidget {
  MediterranesnDietView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.currentTime})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final DateTime currentTime;
  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MediterranesnDietView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void didUpdateWidget(MediterranesnDietView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentTime != oldWidget.currentTime) {
      if (widget.currentTime.isAfter(oldWidget.currentTime)) {
        _totalCalorie = _nextTotalCalorie;
      }
      if (widget.currentTime.isBefore(oldWidget.currentTime)) {
        _totalCalorie = _prevTotalCalorie;
      }
      asyncMethod();
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    asyncMethod();
    super.initState();
  }

  Future<bool> asyncMethod() async {
    DateTime dateTime = widget.currentTime;
    _totalCalorie = await _loadCal(dateTime);
    dateTime = dateTime.add(Duration(days: 1));
    _nextTotalCalorie = await _loadCal(dateTime);
    dateTime = dateTime.add(Duration(days: -2));
    _prevTotalCalorie = await _loadCal(dateTime);
    _planDailyCalorie = await _loadPlan();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(68.0),
                      bottomLeft: Radius.circular(68.0),
                      bottomRight: Radius.circular(68.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Center(
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: FitnessAppTheme.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(250.0),
                                  ),
                                  border: new Border.all(
                                      width: 4,
                                      color: FitnessAppTheme.nearlyDarkBlue
                                          .withOpacity(0.2)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _planDailyCalorie == null
                                        ? Text(
                                            'Diet Plan Not Set',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.dark_grey,
                                              //.withOpacity(0.5),
                                            ),
                                          )
                                        : Text(
                                            '${((_planDailyCalorie - _totalCalorie) * widget.mainScreenAnimation.value).toInt()}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 45,
                                              letterSpacing: 0.0,
                                              color: (_planDailyCalorie -
                                                          _totalCalorie) >=
                                                      0
                                                  ? FitnessAppTheme
                                                      .nearlyDarkBlue
                                                  : HexColor("#900C3F"),
                                            ),
                                          ),
                                    _planDailyCalorie == null
                                        ? Text(
                                            'Please setup your diet plan at the diet plan section on app drawer',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          )
                                        : Text(
                                            (_planDailyCalorie -
                                                        _totalCalorie) >=
                                                    0
                                                ? 'Kcal left'
                                                : 'Over goal',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                '${(_totalCalorie * widget.mainScreenAnimation.value).toInt()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: FitnessAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                '/',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: FitnessAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                _planDailyCalorie == null
                                                    ? '${(0 * widget.mainScreenAnimation.value).toInt()}'
                                                    : '${(_planDailyCalorie * widget.mainScreenAnimation.value).toInt()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: FitnessAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                'Kcal',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  letterSpacing: -0.2,
                                                  color: FitnessAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomPaint(
                                painter: CurvePainter(
                                    colors: _planDailyCalorie == null
                                        ? [
                                            FitnessAppTheme.nearlyDarkBlue,
                                            HexColor("#4c62dc"),
                                            HexColor("#8A98E8")
                                          ]
                                        : (_totalCalorie / _planDailyCalorie)
                                                    .round() >=
                                                1
                                            ? [
                                                HexColor("#FF0000"),
                                                HexColor("#900C3F"),
                                                HexColor("#800000")
                                              ]
                                            : [
                                                FitnessAppTheme.nearlyDarkBlue,
                                                HexColor("#4c62dc"),
                                                HexColor("#8A98E8")
                                              ],
                                    angle: _planDailyCalorie == null
                                        ? 360 +
                                            (360 - 360) *
                                                (1.0 -
                                                    widget.mainScreenAnimation
                                                        .value)
                                        : math.min(
                                                (_totalCalorie /
                                                        _planDailyCalorie) *
                                                    360,
                                                360) +
                                            (360 -
                                                    math.min(
                                                        (_totalCalorie /
                                                                _planDailyCalorie) *
                                                            360,
                                                        360)) *
                                                (1.0 -
                                                    widget.mainScreenAnimation
                                                        .value)),
                                child: SizedBox(
                                  width: 260,
                                  height: 260,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int keyPointer; //id, name, cal, timeStamp
  Future<int> _loadCal(DateTime dateTime) async {
    int tempTotalCalorie = 0;
    keyPointer = 0;
    int index = 0;
    int calorie;
    DateTime timeStamp;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _history = (prefs.getStringList('history') ?? null);
    if (_history != null) {
      do {
        String text = _history.elementAt(index);
        if (keyPointer == 2) calorie = int.parse(text);
        if (keyPointer == 3) timeStamp = DateTime.parse(text);
        keyPointer++;
        if (keyPointer == 4) {
          keyPointer = 0;
          if (timeStamp.month == dateTime.month &&
              timeStamp.day == dateTime.day)
            tempTotalCalorie = tempTotalCalorie + calorie;
        }
        index++;
      } while (index < _history.length);
    }
    return tempTotalCalorie;
    //_planDailyCalorie
  }

  Future<int> _loadPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getInt('plan_daily_calorie') ?? null);
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
