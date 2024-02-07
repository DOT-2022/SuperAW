
import 'dart:convert';
import 'dart:typed_data';

import 'package:AWC/app/app.locator.dart';
import 'package:AWC/app/app.router.dart';
import 'package:AWC/screens/widgets/app_widgets.dart';
import 'package:AWC/services/db/db.dart';
import 'package:AWC/utils/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WorkerViewModel extends BaseViewModel {
  final DBHelper _dbHelper = locator<DBHelper>();
  NavigationService navigationService = locator<NavigationService>();
  DialogService dialogService = locator<DialogService>();
  List<Map<String, dynamic>> workers = [];
  List<Map<String, dynamic>> workersList = [];

  BuildContext? _context;
  BuildContext get context => _context!;

  init() async {
    await loadData();
  }

  loadData() async {
    print('Called Load data');
    workers = await _dbHelper.getData('workers', 'c_id');
    workersList = workers;

    print(workers);
    notifyListeners();
  }

  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  callNumber(String num) async {
    print(num);
    await FlutterPhoneDirectCaller.callNumber(num);
  }


  search(String keyword) async {
    print(keyword);
    if(keyword.isNotEmpty){
      List<Map<String, dynamic>> filteredWorkers = filterWorkers(workersList, keyword);

      if(filteredWorkers.isNotEmpty) {
        workers = filteredWorkers;
      } else {
        workers.clear();
      }
    } else {
      workers = workersList;
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> filterWorkers(List<Map<String, dynamic>> workers, String keyword) {
    return workers.where((worker) {
      return worker['c_name'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          worker['c_id'].toString().contains(keyword.toLowerCase()) ||
          worker['name'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          worker['contact'].toString().contains(keyword.toLowerCase());
    }).toList();
  }

  goNext() {
    navigationService.navigateToNewWorkerView().then((value) => loadData());
  }

  decodeBase64(String base64) {
    Uint8List bytes = const Base64Decoder().convert(base64);
    return bytes;
  }

  editWorker(Map<String, dynamic> worker) {
    navigationService.navigateToUpdateWorkerView(currentWorker: worker).then((value) =>
        loadData());
  }

  deleteWorker(int id) async {
    int result = await _dbHelper.deleteRecord('workers', id);
    await loadData();
    if(result == 1) {
      await AppWidgets.showCustomDialog(
          _context!,
          'Delete Record',
          'Successfully Deleted Worker');
    } else {
      await AppWidgets.showCustomDialog(
          _context!,
          'Delete Record',
          'Delete Failed. Please try again later.');
    }
  }

  editCenter(Map<String, dynamic> worker) async {
    await navigationService.navigateToUpdateWorkerView(currentWorker: worker).then((value) =>
        loadData());
  }

  showConfirmationDialog(int id, String centerName) async {
    var response = await dialogService.showDialog(
      title: 'Delete Record',
      description: 'You asked to delete Center: "$centerName". Are you sure?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
      buttonTitleColor: ColorManager.grad_4,
      cancelTitleColor: ColorManager.grad_8
    );

    if (response!.confirmed) {
      await deleteWorker(id);
    }
  }
}