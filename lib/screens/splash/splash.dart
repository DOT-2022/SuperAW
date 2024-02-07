
import 'package:AWC/screens/splash/splash_view_model.dart';
import 'package:AWC/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      onViewModelReady: (model) => model.init(),
        viewModelBuilder: () => SplashViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: ColorManager.grad_1,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80,),
                    const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUPER AW',
                              style: TextStyle(
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: ColorManager.light
                              ),
                            ),
                            Text(
                              'Crafted with ❤︎ by DOT',
                              style: TextStyle(
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: ColorManager.light
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * .12,
                      padding: const EdgeInsets.all(20),
                      child: Image.asset('assets/images/dot_logo.png'),
                    )
                  ],
                ),
              )
          );
        });
  }
}
