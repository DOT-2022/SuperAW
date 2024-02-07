import 'package:AWC/screens/dashboard/dashboard_view.dart';
import 'package:AWC/screens/helpers/helper_view.dart';
import 'package:AWC/screens/map/map_view.dart';
import 'package:AWC/screens/splash/splash.dart';
import 'package:AWC/screens/workers/create_worker/new_worker_view.dart';
import 'package:AWC/screens/workers/update_worker/update_worker_view.dart';
import 'package:AWC/screens/workers/worker_view.dart';
import 'package:AWC/services/db/db.dart';
import 'package:AWC/services/image_picker.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:AWC/screens/centers/center_view.dart';
import 'package:AWC/screens/centers/new_center/new_center_view.dart';
import 'package:AWC/screens/centers/update_center/update_center_view.dart';


@StackedApp(
  routes: [
      // @stacked-route
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: DashboardView,),
    MaterialRoute(page: CenterView),
    MaterialRoute(page: WorkerView),
    MaterialRoute(page: HelperView),
    MaterialRoute(page: MapView),
    MaterialRoute(page: NewCenterView),
    MaterialRoute(page: UpdateCenterView),
    MaterialRoute(page: UpdateWorkerView),
    MaterialRoute(page: NewWorkerView),
  ],
  dependencies: [
    // @stacked-service
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DBHelper),
    LazySingleton(classType: ImagePickerService),
    LazySingleton(classType: DialogService),
  ],
)
class App{}