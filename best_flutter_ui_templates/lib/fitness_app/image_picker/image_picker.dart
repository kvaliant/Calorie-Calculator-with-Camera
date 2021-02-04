import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/main.dart';
import '../fintness_app_theme.dart';

class CameraModule extends StatefulWidget {
  CameraModule({Key key}) : super(key: key);

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
      isVideo = false;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Semantics(
              label: 'image_picker_example_from_gallery',
              child: InkWell(
                onTap: () {
                  _onImageButtonPressed(ImageSource.camera, context: context);
                },
                /*
            onPressed: ,
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            */
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
                /*
            onPressed: ,
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            */
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
        ),
      ],
    );
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
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);

/*
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class CameraModule extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<CameraModule> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return FlatButton(
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => _openImage(),
    );
  }

  Future<void> _openImage() async {
    final file = await ImagePicker.pickImage(source: ImageSource.camera);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    debugPrint('$file');
  }
}
*/
