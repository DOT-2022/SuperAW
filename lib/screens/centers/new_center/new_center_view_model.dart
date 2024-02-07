import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:AWC/app/app.locator.dart';
import 'package:AWC/services/db/db.dart';
import 'package:AWC/services/extensions.dart';
import 'package:AWC/services/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:AWC/screens/widgets/app_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class NewCenterViewModel extends BaseViewModel {
  final DBHelper _dbHelper = locator<DBHelper>();
  ImagePickerService imagePicker = locator<ImagePickerService>();

  TextEditingController cNameCtrl = TextEditingController();
  TextEditingController cAddressCtrl = TextEditingController();
  TextEditingController cCodeCtrl = TextEditingController();
  TextEditingController cIdCtrl = TextEditingController();
  TextEditingController cLatCtrl = TextEditingController();
  TextEditingController cLongCtrl = TextEditingController();
  TextEditingController cTypeCtrl = TextEditingController();
  TextEditingController cBuildingCtrl = TextEditingController();
  TextEditingController cBuildingOwnerCtrl = TextEditingController();
  TextEditingController cLandmarkCtrl = TextEditingController();

  late Position currentPosition;

  BuildContext? _context;
  BuildContext get context => _context!;

  bool imageLink = false;
  late File imageFile;
  final List<XFile> _imgPath = [];
  List<XFile> get imgPath => _imgPath;

  XFile? _image;
  XFile? get image => _image;
  String _imgStr = '';
  String get imgStr => _imgStr;

  bool checkbox1 = true;
  bool checkbox2 = false;
  bool checkbox3 = false;

  bool checkbox4 = true;
  bool checkbox5 = false;
  bool checkbox6 = false;

  bool checkbox7 = true;
  bool checkbox8 = false;
  bool checkbox9 = false;

  setBuildContext(BuildContext context) {
    _context = context;
    cBuildingCtrl.text = 'School';
    cBuildingOwnerCtrl.text = 'Owned';
    cTypeCtrl.text = 'Pakka';
    notifyListeners();
  }

  void addImageByCamera() async {
    _image = await imagePicker.getImageFromCamera();
    if (_image != null) {
      File file = File(_image!.path);
      imageFile = file;
      Uint8List uint8 = file.readAsBytesSync();
      _imgStr = base64.encode(uint8);
      imageLink = true;
      notifyListeners();
    }
  }

  void setCheckbox1(bool value) {
    checkbox1 = value;
    if (value) {
      checkbox2 = false;
      checkbox3 = false;
      cBuildingCtrl.text = 'School';
    }
    notifyListeners();
  }

  void setCheckbox2(bool value) {
    checkbox2 = value;
    if (value) {
      checkbox1 = false;
      checkbox3 = false;
      cBuildingCtrl.text = 'Open Space';
    }
    notifyListeners();
  }

  void setCheckbox3(bool value) {
    checkbox3 = value;
    if (value) {
      checkbox1 = false;
      checkbox2 = false;
      cBuildingCtrl.text = 'Panchayat';
    }
    notifyListeners();
  }

  void setCheckbox4(bool value) {
    checkbox4 = value;
    if (value) {
      checkbox5 = false;
      checkbox6 = false;
      cBuildingOwnerCtrl.text = 'Owned';
    }
    notifyListeners();
  }

  void setCheckbox5(bool value) {
    checkbox5 = value;
    if (value) {
      checkbox4 = false;
      checkbox6 = false;
      cBuildingOwnerCtrl.text = 'Rented';
    }
    notifyListeners();
  }

  void setCheckbox6(bool value) {
    checkbox6 = value;
    if (value) {
      checkbox4 = false;
      checkbox5 = false;
      cBuildingOwnerCtrl.text = 'Others';
    }
    notifyListeners();
  }

  void setCheckbox7(bool value) {
    checkbox7 = value;
    if (value) {
      checkbox8 = false;
      checkbox9 = false;
      cTypeCtrl.text = 'Pakka';
    }
    notifyListeners();
  }

  void setCheckbox8(bool value) {
    checkbox8 = value;
    if (value) {
      checkbox7 = false;
      checkbox9 = false;
      cTypeCtrl.text = 'Semi-Pakka';
    }
    notifyListeners();
  }

  void setCheckbox9(bool value) {
    checkbox9 = value;
    if (value) {
      checkbox7 = false;
      checkbox8 = false;
      cTypeCtrl.text = 'Katcha';
    }
    notifyListeners();
  }

  void addImageByGallery() async {
    _image = await imagePicker.getImageFromGallery();
    if (_image != null) {
      File file = File(_image!.path);
      imageFile = file;
      Uint8List uint8 = file.readAsBytesSync();
      _imgStr = base64.encode(uint8);
      imageLink = true;
      notifyListeners();
    }
  }

  void getCurrentLocation() async {
    await AppWidgets.showProgress(_context!, 'Searching...', false);
    Position position = await _determinePosition();
    currentPosition = position;
    cLatCtrl.text = position.latitude.toString();
    cLongCtrl.text = position.longitude.toString();
    await getAddress();
    await AppWidgets.cancelProgress(_context!);
    notifyListeners();
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
// When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getAddress() async {
    List<Placemark> placeMark = await placemarkFromCoordinates(currentPosition.latitude,
        currentPosition.longitude);
    Placemark place = placeMark[0];
    cAddressCtrl.text = '${place.locality}, ${place.street}, ${place.name}, ${place
        .administrativeArea}, ${place.postalCode}, ${place.country}';
  }

  submit() async {
    bool validated = validateFields();
    if(validated) {
      AppWidgets.showProgress(context, 'Creating Center. Please Wait!', false);
      Map<String, dynamic> params = getParams();

      int result = await _dbHelper.createCenter(params);
      AppWidgets.cancelProgress(_context!);
      if(result > 0) {
        await AppWidgets.showCustomDialog(
          _context!,
          'Center Registration',
          'Congrats! New Center Registered Successfully.');
        resetScreen();
      } else {
        await AppWidgets.showCustomDialog(
            _context!,
            'Center Registration',
            "Registration Failed! Center with ID [ ${params['c_id']} ] already exists.");
      }

    } else {
      await AppWidgets.showCustomDialog(_context!, 'Center Registration',
          'Required fields are Missing or Not Fulfilled. Please Check & Try Again.',);
    }
  }

  resetScreen() {
    cNameCtrl.clear();
    cBuildingCtrl.text = '';
    cBuildingOwnerCtrl.text = '';
    cTypeCtrl.text = '';
    cLatCtrl.clear();
    cLandmarkCtrl.clear();
    cLongCtrl.clear();
    cAddressCtrl.clear();
    cCodeCtrl.clear();
    cIdCtrl.clear();
    _imgStr="";
    checkbox1 = checkbox2 = checkbox3 = false;
    checkbox4 = checkbox5 = checkbox6 = false;
    checkbox7 = checkbox8 = checkbox9 = false;

    notifyListeners();
  }

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = {
      'c_id': '',
      'code': '',
      'name': '',
      'address': '',
      'landmark': '',
      'community_building': '',
      'building_ownership': '',
      'c_type' : '',
      'lat': '',
      'long': '',
      'image': '',
    };

    params['c_id'] = cIdCtrl.text.toString();
    params['code'] = cCodeCtrl.text.toString();
    params['name'] = cNameCtrl.text.toString().capitalizeFirstLetterOfEachWord();
    params['address'] = cAddressCtrl.text.toString().capitalizeFirstLetterOfEachWord();
    params['community_building'] = cBuildingCtrl.text;
    params['building_ownership'] = cBuildingOwnerCtrl.text;
    params['c_type'] = cTypeCtrl.text;
    params['lat'] = cLatCtrl.text;
    params['long'] = cLongCtrl.text;
    params['landmark'] = cLandmarkCtrl.text.capitalizeFirstLetterOfEachWord();
    params['image'] = imgStr.toString();

    print(params);

    return params;
  }

  bool validateFields() {
    if(
      cIdCtrl.text.isEmpty ||
      cCodeCtrl.text.isEmpty ||
      cNameCtrl.text.isEmpty ||
      cTypeCtrl.text.isEmpty ||
      cAddressCtrl.text.isEmpty ||
      cIdCtrl.text.length < 3 ||
      cCodeCtrl.text.length < 11 ||
      cNameCtrl.text.length <3 ||
      cAddressCtrl.text.length < 3
    ) {
      return false;
    } else {
      return true;
    }
  }
}