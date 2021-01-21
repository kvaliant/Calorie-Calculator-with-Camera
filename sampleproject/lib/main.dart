// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum genderEnum { male, female }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      home: _test(),
    );
  }
}

Widget _test() {
  return MaterialApp(
    title: 'Welcome to Flutter',
    home: Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text(
              'Male',
              style: TextStyle(fontSize: 16),
            ),
            leading: Radio(
              value: genderEnum.male,
              groupValue: genderEnum,
              onChanged: (value) {
                print('test');
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Female',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            leading: Radio(
              value: genderEnum.female,
              groupValue: genderEnum,
              onChanged: (value) {
                print('test');
              },
            ),
          ),
        ],
      ),
    ),
  );
}
