import 'dart:convert';
import 'dart:typed_data';

import 'package:AWC/utils/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:AWC/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../services/db/db.dart';
import '../widgets/app_widgets.dart';

class CenterViewModel extends BaseViewModel {
  BuildContext? _context;
  BuildContext get context => _context!;
  final DBHelper _dbHelper = locator<DBHelper>();
  NavigationService navigationService = locator<NavigationService>();
  DialogService dialogService = locator<DialogService>();

  List<Map<String, dynamic>> centers = [];
  List<Map<String, dynamic>> centerList = [];
  List<Map<String, dynamic>> workerList = [];
  List<Map<String, dynamic>> combinedData = [];

  bool isExpanded = false;

  loadData() async {
    centers =[];
    centerList = [];
    combinedData = [];
    centers = await _dbHelper.getData('centers', 'c_id');
    workerList = await _dbHelper.getCentersWorkers();
    centerList = centers;

    await combined();
  }

  combined() {
    // Iterate through each center
    if(centers.isNotEmpty){
      for (var center in centers) {
        // Find worker associated with the center ID
        var worker = workerList.firstWhere(
                (worker) => worker['c_id'] == center['c_id'],
            orElse: () {
              Map<String, dynamic> temp = {
                'w_name' : '',
                'w_contact' : ''
              };
              return temp;
            }
        );

        // Create a new map with center and worker details combined
        Map<String, dynamic> combinedCenterData = {
          'id': center['id'],
          'code': center['code'],
          'c_id': center['c_id'],
          'name': center['name'],
          'c_type': center['c_type'],
          'community_building': center['community_building'],
          'building_ownership': center['building_ownership'],
          'address': center['address'],
          'landmark': center['landmark'],
          'lat': center['lat'],
          'long': center['long'],
          'image': center['image'],
          'created_at': center['created_at'],
          // Add other center properties
        };

        // If worker is found, add worker details to the combined data
        if (worker.isNotEmpty) {
          combinedCenterData['w_name'] = worker['w_name'];
          combinedCenterData['w_contact'] = worker['w_contact'];
          // Add other worker properties if needed
        }

        // Add combined center data to the new list
        combinedData.add(combinedCenterData);
        centers = combinedData;
        centerList = centers;

      }
    } else {
      centers = [];
    }
    notifyListeners();
  }

  onExpandClick(bool val) {
    isExpanded = val;
    notifyListeners();
  }

  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  decodeBase64(String base64) {
    Uint8List bytes = const Base64Decoder().convert(base64);
    return bytes;
  }

  search(String keyword) async {
    if(keyword.isNotEmpty){
      List<Map<String, dynamic>> filteredCenters = filterCenters(centerList, keyword);

      if(filteredCenters.isNotEmpty) {
        centers = filteredCenters;
      } else {
        centers.clear();
      }
    }else {
      centers = centerList;
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> filterCenters(List<Map<String, dynamic>> centers, String keyword) {
    return centers.where((center) {
      return center['code'].toString().contains(keyword.toLowerCase()) ||
          center['c_id'].toString().contains(keyword.toLowerCase()) ||
          center['name'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          center['address'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          center['landmark'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          center['c_type'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          center['community_building'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
          center['building_ownership'].toString().toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }

  editCenter(Map<String, dynamic> center) async {
    await navigationService.navigateToUpdateCenterView(currentCetner: center).then((value) => loadData());
  }

  deleteCenter(int id) async {
    int result = await _dbHelper.deleteRecord('centers', id);
    if(result == 1) {
     await loadData();

      await AppWidgets.showCustomDialog(
          _context!,
          'Delete Center',
          'Successfully Deleted Center');
    } else {
      await AppWidgets.showCustomDialog(
          _context!,
          'Delete Center',
          'Delete Failed. Please try again later.');
    }
  }

  showConfirmationDialog(int id, String centerName) async {
    var response = await dialogService.showDialog(
        title: 'Delete Record',
        description: 'You asked to delete Center: "$centerName". Are you sure? NOTE: Worker details will be deleted if already linked',
        buttonTitle: 'Delete',
        cancelTitle: 'Cancel',
        buttonTitleColor: ColorManager.grad_4,
        cancelTitleColor: ColorManager.grad_8
    );
    if (response!.confirmed) {
      await deleteCenter(id);
    }
  }

  void goNext() {
    navigationService.navigateToNewCenterView().then((value) => loadData());
  }
}