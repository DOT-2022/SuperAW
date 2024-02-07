
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:AWC/app/app.locator.dart';
import 'package:AWC/models/centers_model.dart';
import 'package:AWC/screens/widgets/app_widgets.dart';
import 'package:AWC/services/db/db.dart';
import 'package:AWC/services/extensions.dart';
import 'package:AWC/services/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class NewWorkerViewModel extends BaseViewModel {
  List<Map<String, dynamic>> workers = [];
  List<Map<String, dynamic>> centers = [];
  Map<String, dynamic> selectedCenter = {};
  List<Centers> multipleCenters = [];
  List<Centers> allCenters = [];
  late List<String> allCentersName;
  List<String> centersName = ['Select Center'];
  List<String> selectedCenters = [];

  final DBHelper _dbHelper = locator<DBHelper>();
  ImagePickerService imagePicker = locator<ImagePickerService>();

  TextEditingController wNameCtrl = TextEditingController();
  TextEditingController wContactCtrl = TextEditingController();

  BuildContext? _context;
  BuildContext get context => _context!;

  bool imageLink = false;
  bool isMultiple = false;

  bool checkbox1 = false;
  bool checkbox2 = true;
  List<Map<String,dynamic>> finalCenters = [
    {
      'cid': '',
      'name' : ''
    }
  ];

  final _multiSelectKey = GlobalKey<FormFieldState>();
  get multiSelectKey => _multiSelectKey;

  late File imageFile;
  final List<XFile> _imgPath = [];
  List<XFile> get imgPath => _imgPath;

  XFile? _image;
  XFile? get image => _image;
  late String _imgStr = '';
  String get imgStr => _imgStr;
  String selectedCenterName = 'Select Center';

  init() async {
    await getAllCenters();
  }

  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  getAllCenters() async {
    centers = await _dbHelper.getData('centers', 'c_id');
    for (var element in centers) {
      allCenters.add(
          Centers(
            cNo : element['c_id'].toString(),
            name : element['name']
          )
      );

      centersName.add(element['name']);
    }
    notifyListeners();
  }

  void setCheckbox1(bool value) {
    if (value) {
      checkbox1 = true;
      checkbox2 = false;
      isMultiple = true;
    }
    notifyListeners();
  }

  void setCheckbox2(bool value) {

    if (value) {
      checkbox1 = false;
      isMultiple = false;
      checkbox2 = true;
    }
    notifyListeners();
  }

  updateCenterDetails(String centerName) {
    if(centerName.isNotEmpty && centerName != 'Select Center'){
      selectedCenter = centers.firstWhere((element) => (element['name'] == centerName));
      if(selectedCenter.isNotEmpty) {
        finalCenters.clear();
        finalCenters.add({
          'cid' : selectedCenter['c_id'].toString(),
          'name' : selectedCenter['name'].toString(),
        });
        print(finalCenters);
      }
    } else{
      finalCenters.clear();
    }

    selectedCenterName = centerName;
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

  addCenters(item) {
    selectedCenters.clear();
    finalCenters.clear();
    for(var element in item) {
      selectedCenters.add(element.name);
      finalCenters.add({
        'cid' : element.cNo,
        'name' : element.name,
      });
    }
  }

  submit() async {
    bool validated = validateFields();
    if(validated) {
      AppWidgets.showProgress(context, 'Registering. Please Wait!', false);
      Map<String, dynamic> params = getParams();

      Map<String, dynamic> result = await _dbHelper.createWorker(params);
      AppWidgets.cancelProgress(_context!);
      if(result['status']) {
        await AppWidgets.showCustomDialog(
            _context!,
            'Worker Registration',
            'Congrats! Worker Registered Successfully.');
        resetScreen();
      } else {
        String cIds = '[ ';
        for(var element in result['duplicates']) {
          cIds = '$cIds ${element['cid']} ';
        }
        cIds = '$cIds ]';

        await AppWidgets.showCustomDialog(
            _context!,
            'Worker Registration',
            'Found Duplicates: Workers already mapped with Center IDs $cIds');
      }

    } else {
      await AppWidgets.showCustomDialog(_context!, 'Worker Registration',
        'Required Fields Are Missing or not valid. Please Check & Try Again.',);
    }
  }

  resetScreen() {
    wNameCtrl.clear();
    wContactCtrl.clear();
    _imgStr="";
    isMultiple = false;
    finalCenters.clear();
    selectedCenters.clear();
    selectedCenterName = 'Select Center';
    imageLink = false;
    notifyListeners();
  }

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = {
      'w_name' : '',
      'w_contact' : '',
      'multiple' : 0,
      'name': [],
      'image': '',
    };

    params['w_name'] = wNameCtrl.text.toString().capitalizeFirstLetterOfEachWord();
    params['w_contact'] = wContactCtrl.text.toString();
    params['name'] = finalCenters;
    (isMultiple) ? params['multiple']=1 : params['multiple']=0;
    params['image'] = imgStr.toString();

    return params;
  }

  bool validateFields() {
    if(
      wNameCtrl.text.isEmpty ||
      wContactCtrl.text.isEmpty ||
      finalCenters.isEmpty ||
      wContactCtrl.text.length < 10 ||
      wNameCtrl.text.length < 3
    ) {
      return false;
    } else {
      return true;
    }
  }
}