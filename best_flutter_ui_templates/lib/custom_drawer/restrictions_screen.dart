import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/restrictions_list_data.dart';
import 'package:flutter/material.dart';

class RestrictionsScreen extends StatefulWidget {
  @override
  _RestrictionsScreenState createState() => _RestrictionsScreenState();
}

class _RestrictionsScreenState extends State<RestrictionsScreen> {
  List<RestrictionsListData> restrictionsList =
      RestrictionsListData.restrictionsList;

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
                  restrictionsList.elementAt(index).active
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank),
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
