import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:AWC/screens/dashboard/dashboard_view_model.dart';
import 'package:AWC/utils/color_manager.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorManager.medium,
          appBar: AppBar(
            title: const Text(
              'Supervisor App',
              style: TextStyle(
                fontSize: 18,
                color: ColorManager.light,
                fontFamily: 'ProximaNova'
            )),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.settings,
                    color: ColorManager.light,
                  )
              )
            ],
            backgroundColor: ColorManager.grad_1,
          ),
          body: getLogin(model, context),
        );
      });
  }
}

Widget getLogin(DashboardViewModel model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  model.goNext('center');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      gradient:
                      LinearGradient(
                        colors: [ColorManager.grad_7, ColorManager.grad_2 ],
                        transform: GradientRotation(math.pi / 3),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.home_work, size: 30, color: ColorManager.lightGrey),
                        Text('Centers', style: TextStyle(
                            color: ColorManager.lightDark,
                            fontSize: 12,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  model.goNext('worker');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      gradient:
                      LinearGradient(
                        colors: [ColorManager.grad_13, ColorManager.grad_14],
                        transform: GradientRotation(math.pi / 12),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.people_alt_rounded, size: 30, color: ColorManager.lightGrey),
                        Text('Workers', style: TextStyle(
                            color: ColorManager.lightGrey,
                            fontSize: 12,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // model.goNext('helper');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ColorManager.grad_3, ColorManager.grad_13],
                        transform: GradientRotation(math.pi / 4),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.personal_injury_outlined, size: 30, color: ColorManager.lightGrey),
                        Text('Helpers', style: TextStyle(
                            color: ColorManager.lightGrey,
                            fontSize: 12,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // model.goNext('map');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ColorManager.grad_15, ColorManager.grad_5],
                        transform: GradientRotation(math.pi / 4),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.location_on_sharp, size: 30, color: ColorManager.lightGrey),
                        Text('   Map   ', style: TextStyle(
                            color: ColorManager.lightGrey,
                            fontSize: 12,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40,),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Basic Info :',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorManager.grad_10,
              fontFamily: 'ProximaNova',
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: MediaQuery.of(context).size.height*.45,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      model.goNext('center');
                    },
                    child: Card(
                      color: ColorManager.grad_1,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              'CENTERS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'ProximaNova',
                                  color: ColorManager.grad_5
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              model.totalCenters,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: 'ProximaNova',
                                  color: ColorManager.grad_5
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      model.goNext('worker');
                    },
                    child: Card(
                      color: ColorManager.grad_1,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              'WORKERS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'ProximaNova',
                                  color: ColorManager.grad_5
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              model.totalHelpers,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: 'ProximaNova',
                                  color: ColorManager.grad_5
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )
  );
  // Card(
}
