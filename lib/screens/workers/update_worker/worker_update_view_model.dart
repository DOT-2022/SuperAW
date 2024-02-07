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
import 'package:stacked/stacked.dart';

class UpdateWorkerViewModel extends BaseViewModel {
  Map<String, dynamic> worker = {};

  List<Map<String, dynamic>> workers = [];
  List<Map<String, dynamic>> centers = [];
  Map<String, dynamic> selectedCenter = {};
  List<Centers> multipleCenters = [];
  List<Centers> allCenters = [];
  late List<String> allCentersName;
  List<String> centersName = ['Select Center'];
  List<String> selectedCenters = [];
  List<String> previouslySelected = [];

  final DBHelper _dbHelper = locator<DBHelper>();
  ImagePickerService imagePicker = locator<ImagePickerService>();

  TextEditingController wNameCtrl = TextEditingController();
  TextEditingController wContactCtrl = TextEditingController();

  BuildContext? _context;
  BuildContext get context => _context!;

  bool imageLink = false;
  bool isMultiple = false;
  bool isByteImage = false;

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
  late Uint8List bytesImage;

  XFile? _image;
  XFile? get image => _image;
  String _imgStr = '';
  String get imgStr => _imgStr;
  String selectedCenterName = 'Select Center';

  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  init() async {
    await getAllCenters();
    wNameCtrl.text = worker['name'].toString().capitalizeFirstLetterOfEachWord();
    wContactCtrl.text = worker['contact'];
    if(worker['image'].isNotEmpty) {
      // final decodedBytes = base64Decode(center['image']);
      bytesImage = const Base64Decoder().convert(worker['image']);
      isByteImage = true;
      imageLink = true;
    }
    if(worker['multiple'] == 1) {
      checkbox1 = true;
      checkbox2 = false;
      isMultiple = true;
      await getMultipleCenters(worker['name']);
    } else {
      setCheckbox2(true);
      selectedCenterName = worker['c_name'];
      finalCenters.clear();
      finalCenters.add({
        'cid' : worker['c_id'],
        'name' : worker['c_name']
      });
    }
    notifyListeners();
  }

  getMultipleCenters(String wName) async {
    selectedCenters = await _dbHelper.getMultipleCenters(wName);
    print(selectedCenters);
    // previouslySelected = await _dbHelper.getMultipleCenters(wName);
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

      // previouslySelected.add(element['name']);
      centersName.add(element['name']);
    }
    notifyListeners();
  }

  void setCheckbox1(bool value) {

    if (value) {
      checkbox1 = value;
      checkbox2 = false;
      isMultiple = true;
    }
    notifyListeners();
  }

  void setCheckbox2(bool value) {

    if (value) {
      checkbox2 = value;
      checkbox1 = false;
      isMultiple = false;
    }
    notifyListeners();
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

  resetScreen() {
    wNameCtrl.clear();
    wContactCtrl.clear();
    _imgStr="";
    isMultiple = false;
    finalCenters.clear();
    selectedCenters.clear();
    selectedCenterName = 'Select Center';

    notifyListeners();
  }

  Map<String, dynamic> getParams() {
    Map<String, dynamic> params = {
      'id' : 0,
      'w_name' : '',
      'w_contact' : '',
      'multiple' : false,
      'name': [],
      'isCenterChanged' : false,
      'image': '',
    };

    params['id'] = worker['id'];
    params['w_name'] = wNameCtrl.text.toString().capitalizeFirstLetterOfEachWord();
    params['w_contact'] = wContactCtrl.text.toString();
    params['name'] = finalCenters;
    (worker['c_name'] != finalCenters[0]['name'])
        ? params['isCenterChanged'] = true
        : params['isCenterChanged'] = false;
    params['multiple'] = isMultiple;
    params['image'] = worker['image'];

    return params;
  }

  bool validateFields() {
    if(
      wNameCtrl.text.isEmpty ||
      wContactCtrl.text.isEmpty ||
      finalCenters.isEmpty ||
      wContactCtrl.text.length < 10
    ) {
      return false;
    } else {
      return true;
    }
  }

  submit() async {
    bool validated = validateFields();

    if(validated) {
      AppWidgets.showProgress(context, 'Registering. Please Wait!', false);
      Map<String, dynamic> params = getParams();
      Map<String, dynamic> result = await _dbHelper.updateWorker(params);
      AppWidgets.cancelProgress(_context!);

      if(result['status']) {
        await AppWidgets.showCustomDialog(
            _context!,
            'Worker Registration',
            result['message']);
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
            result['message']);
      }

    } else {
      await AppWidgets.showCustomDialog(_context!, 'Worker Registration',
        'Required Fields Are Missing or not valid. Please Check & Try Again.',);
    }
  }
}