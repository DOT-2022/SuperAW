
import 'package:AWC/app/app.locator.dart';
import 'package:AWC/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {

  NavigationService navigationService = locator<NavigationService>();

  init() async {
    await Future.delayed(const Duration(seconds: 5), goNext);
  }

  goNext(){
    navigationService.replaceWithDashboardView();
  }
}