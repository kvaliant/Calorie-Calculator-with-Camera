import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/restrictions_list_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestrictionsScreen extends StatefulWidget {
  @override
  _RestrictionsScreenState createState() => _RestrictionsScreenState();
}

class _RestrictionsScreenState extends State<RestrictionsScreen> {
  List<RestrictionsListData> restrictionsList =
      RestrictionsListData.restrictionsList;

  List<String> _restrictionsActiveList = [];

  _loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _restrictionsActiveList =
          (prefs.getStringList('restrictionsActiveList') ?? []);
      for (int i = 0; i < restrictionsList.length; i++) {
        _restrictionsActiveList.add('false');
      }
    });
  }

  //Incrementing counter after click
  Future<bool> _saveAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('restrictionsActiveList', _restrictionsActiveList);
    return true;
  }

  @override
  void initState() {
    setState(() {
      _loadAll();
    });
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
                      'Food Restrictions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'We will give you a warning when certain food might contain ingredients that match your dietary restrictions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: _allergiesGrid(),
                  ),
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
                              _saveAll();
                              Navigator.of(context).push(ShowOverlay());
                              FocusScope.of(context).requestFocus(FocusNode());
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
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      '\n\n\n\n\n\n\n\n\n\n',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _allergiesGrid() {
    return Expanded(
      child: GridView.count(
        primary: false,
        childAspectRatio: 3 / 1,
        crossAxisCount: 3,
        children: List.generate(restrictionsList.length, (index) {
          return Expanded(
            child: Container(
              height: 25,
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _restrictionsActiveList[index] =
                            _restrictionsActiveList.elementAt(index) == 'true'
                                ? 'false'
                                : 'true';
                      });
                    },
                    child: _restrictionsActiveList.elementAt(index) == 'true'
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank),
                  ),
                  Text(restrictionsList.elementAt(index).restrictionsName),
                ],
              ),
            ),
          );
        }),
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
