import 'package:flutter/material.dart';
import 'package:AWC/screens/helpers/helper_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_manager.dart';

class HelperView extends StatelessWidget {
  const HelperView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelperViewModel>.reactive(
        viewModelBuilder: () => HelperViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ColorManager.medium,
            appBar: AppBar(
              title: const Text('Supervisor App', style: TextStyle(color: ColorManager.light)),
              backgroundColor: ColorManager.grad_1,
            ),
            body: Scaffold(),
          );
        });
  }
}
