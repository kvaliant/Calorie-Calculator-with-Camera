import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:io';

import '../fintness_app_theme.dart';

class CameraModule extends StatefulWidget {
  CameraModule({Key key, this.addClick}) : super(key: key);

  final Function addClick;

  @override
  _CameraModuleState createState() => _CameraModuleState();
}

class _CameraModuleState extends State<CameraModule> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  bool isVideo = false;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    await _displayPickImageDialog(context,
        (double maxWidth, double maxHeight, int quality) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setIconImageFile(pickedFile);
        setFunctionImageFile(pickedFile);
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile.path);
      } else {
        return Container(
          width: 200,
          height: 200,
          child: Image.asset(
            _imageFile.path,
            fit: BoxFit.cover,
            width: 200,
            height: 200,
          ),
        );
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: AppTheme.white,
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
            child: Center(
              child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return _previewImage();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : _previewImage(),
            ),
          ),
        ),
        _buildButton(),
      ],
    );
  }

  Widget _buildButton() {
    if (_imageFile == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: InkWell(
              onTap: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, bottom: 10, left: 5, right: 10),
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      FitnessAppTheme.nearlyDarkBlue,
                      HexColor("#6F56E8")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48.0),
                      topRight: Radius.circular(48.0),
                      bottomLeft: Radius.circular(48.0),
                      bottomRight: Radius.circular(48.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withOpacity(0.6),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Camera",
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: FitnessAppTheme.white,
                        ),
                      ),
                      Icon(
                        Icons.camera_alt,
                        color: FitnessAppTheme.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: InkWell(
              onTap: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, bottom: 10, left: 5, right: 10),
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      FitnessAppTheme.nearlyDarkBlue,
                      HexColor("#6F56E8")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48.0),
                      topRight: Radius.circular(48.0),
                      bottomLeft: Radius.circular(48.0),
                      bottomRight: Radius.circular(48.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withOpacity(0.6),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Galery",
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: FitnessAppTheme.white,
                        ),
                      ),
                      Icon(
                        Icons.photo_size_select_actual_outlined,
                        color: FitnessAppTheme.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return FutureBuilder<String>(
          future: _readFileByte(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Semantics(
                    label: 'retry',
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _imageFile = null;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 10, left: 5, right: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  FitnessAppTheme.nearlyDarkBlue,
                                  HexColor("#6F56E8")
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(48.0),
                              topRight: Radius.circular(48.0),
                              bottomLeft: Radius.circular(48.0),
                              bottomRight: Radius.circular(48.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FitnessAppTheme.grey.withOpacity(0.6),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.refresh,
                              color: FitnessAppTheme.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    label: 'next_screen',
                    child: InkWell(
                      onTap: () {
                        widget.addClick(snapshot.data.toString());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: 10, left: 5, right: 10),
                        child: Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  FitnessAppTheme.nearlyDarkBlue,
                                  HexColor("#6F56E8")
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(48.0),
                              topRight: Radius.circular(48.0),
                              bottomLeft: Radius.circular(48.0),
                              bottomRight: Radius.circular(48.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FitnessAppTheme.grey.withOpacity(0.6),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: FitnessAppTheme.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          });
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    onPick(250, 250, 100);
  }

  Future<String> _readFileByte() async {
    File file = File(_imageFile.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://apinoidea.herokuapp.com/api/multipartImage/"),
    );

    Map<String, String> headers = {"Content-Type": "application/octet-stream"};
    request.files.add(
      http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: 'filename',
        contentType: MediaType('image', 'jpg'),
      ),
    );
    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());
    return response.statusCode.toString() + "\n" + response.body.toString();
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
