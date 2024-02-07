// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:AWC/screens/centers/center_view.dart' as _i4;
import 'package:AWC/screens/centers/new_center/new_center_view.dart' as _i8;
import 'package:AWC/screens/centers/update_center/update_center_view.dart'
    as _i9;
import 'package:AWC/screens/dashboard/dashboard_view.dart' as _i3;
import 'package:AWC/screens/helpers/helper_view.dart' as _i6;
import 'package:AWC/screens/map/map_view.dart' as _i7;
import 'package:AWC/screens/splash/splash.dart' as _i2;
import 'package:AWC/screens/workers/create_worker/new_worker_view.dart' as _i11;
import 'package:AWC/screens/workers/update_worker/update_worker_view.dart'
    as _i10;
import 'package:AWC/screens/workers/worker_view.dart' as _i5;
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i13;

class Routes {
  static const splashView = '/';

  static const dashboardView = '/dashboard-view';

  static const centerView = '/center-view';

  static const workerView = '/worker-view';

  static const helperView = '/helper-view';

  static const mapView = '/map-view';

  static const newCenterView = '/new-center-view';

  static const updateCenterView = '/update-center-view';

  static const updateWorkerView = '/update-worker-view';

  static const newWorkerView = '/new-worker-view';

  static const all = <String>{
    splashView,
    dashboardView,
    centerView,
    workerView,
    helperView,
    mapView,
    newCenterView,
    updateCenterView,
    updateWorkerView,
    newWorkerView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i3.DashboardView,
    ),
    _i1.RouteDef(
      Routes.centerView,
      page: _i4.CenterView,
    ),
    _i1.RouteDef(
      Routes.workerView,
      page: _i5.WorkerView,
    ),
    _i1.RouteDef(
      Routes.helperView,
      page: _i6.HelperView,
    ),
    _i1.RouteDef(
      Routes.mapView,
      page: _i7.MapView,
    ),
    _i1.RouteDef(
      Routes.newCenterView,
      page: _i8.NewCenterView,
    ),
    _i1.RouteDef(
      Routes.updateCenterView,
      page: _i9.UpdateCenterView,
    ),
    _i1.RouteDef(
      Routes.updateWorkerView,
      page: _i10.UpdateWorkerView,
    ),
    _i1.RouteDef(
      Routes.newWorkerView,
      page: _i11.NewWorkerView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.DashboardView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.DashboardView(),
        settings: data,
      );
    },
    _i4.CenterView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CenterView(),
        settings: data,
      );
    },
    _i5.WorkerView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.WorkerView(),
        settings: data,
      );
    },
    _i6.HelperView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.HelperView(),
        settings: data,
      );
    },
    _i7.MapView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.MapView(),
        settings: data,
      );
    },
    _i8.NewCenterView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.NewCenterView(),
        settings: data,
      );
    },
    _i9.UpdateCenterView: (data) {
      final args = data.getArgs<UpdateCenterViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.UpdateCenterView(
            key: args.key, currentCetner: args.currentCetner),
        settings: data,
      );
    },
    _i10.UpdateWorkerView: (data) {
      final args = data.getArgs<UpdateWorkerViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.UpdateWorkerView(
            key: args.key, currentWorker: args.currentWorker),
        settings: data,
      );
    },
    _i11.NewWorkerView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.NewWorkerView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class UpdateCenterViewArguments {
  const UpdateCenterViewArguments({
    this.key,
    required this.currentCetner,
  });

  final _i12.Key? key;

  final Map<String, dynamic> currentCetner;

  @override
  String toString() {
    return '{"key": "$key", "currentCetner": "$currentCetner"}';
  }

  @override
  bool operator ==(covariant UpdateCenterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.currentCetner == currentCetner;
  }

  @override
  int get hashCode {
    return key.hashCode ^ currentCetner.hashCode;
  }
}

class UpdateWorkerViewArguments {
  const UpdateWorkerViewArguments({
    this.key,
    required this.currentWorker,
  });

  final _i12.Key? key;

  final Map<String, dynamic> currentWorker;

  @override
  String toString() {
    return '{"key": "$key", "currentWorker": "$currentWorker"}';
  }

  @override
  bool operator ==(covariant UpdateWorkerViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.currentWorker == currentWorker;
  }

  @override
  int get hashCode {
    return key.hashCode ^ currentWorker.hashCode;
  }
}

extension NavigatorStateExtension on _i13.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCenterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.centerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWorkerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.workerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHelperView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.helperView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMapView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mapView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewCenterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newCenterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateCenterView({
    _i12.Key? key,
    required Map<String, dynamic> currentCetner,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateCenterView,
        arguments:
            UpdateCenterViewArguments(key: key, currentCetner: currentCetner),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateWorkerView({
    _i12.Key? key,
    required Map<String, dynamic> currentWorker,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateWorkerView,
        arguments:
            UpdateWorkerViewArguments(key: key, currentWorker: currentWorker),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewWorkerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newWorkerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCenterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.centerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWorkerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.workerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHelperView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.helperView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMapView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mapView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewCenterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newCenterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateCenterView({
    _i12.Key? key,
    required Map<String, dynamic> currentCetner,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateCenterView,
        arguments:
            UpdateCenterViewArguments(key: key, currentCetner: currentCetner),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateWorkerView({
    _i12.Key? key,
    required Map<String, dynamic> currentWorker,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateWorkerView,
        arguments:
            UpdateWorkerViewArguments(key: key, currentWorker: currentWorker),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewWorkerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newWorkerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
