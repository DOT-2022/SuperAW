import 'package:flutter/cupertino.dart';
import 'package:AWC/app/app.router.dart';
import 'package:AWC/services/db/db.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../utils/color_manager.dart';

class DashboardViewModel extends BaseViewModel {
  // Declaration
  NavigationService navigationService = locator<NavigationService>();
  DialogService dialogService = locator<DialogService>();
  final DBHelper _dbHelper = locator<DBHelper>();

  // Initialization
  List<Map<String, dynamic>> centers = [];
  List<Map<String, dynamic>> workers = [];

  String totalCenters = '0';
  String totalHelpers = "0";

  // Initially load all the data from the db.
  init() async {
    centers = await _dbHelper.getData('centers', 'c_id');
    workers = await _dbHelper.getData('workers', 'c_id');
    totalCenters = centers.length.toString();
    totalHelpers = workers.length.toString();
    notifyListeners();
  }

  goNext(String page){
    switch(page) {
      case 'worker':
        navigationService.navigateToWorkerView().then((value) => init());
        break;
      case 'helper':
        navigationService.navigateToHelperView().then((value) => init());
        break;
      case 'map':
        navigationService.navigateToMapView().then((value) => init());
        break;
      default:
        navigationService.navigateToCenterView().then((value) => init());
    }
  }


  settings() {

  }
}