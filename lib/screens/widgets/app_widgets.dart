import 'package:flutter/material.dart';
import 'package:AWC/utils/color_manager.dart';

class AppWidgets {
  static Widget getProgressBar(double height ) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: ColorManager.grad_1,
        ),
      ),
    );
  }

  static showProgress(BuildContext context, String str, bool dismissible) {
    showDialog(
      useSafeArea: true,
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            AppWidgets.getProgressBar(50),
            Padding(padding: const EdgeInsets.only(left: 30), child: Text(str)),
          ],
        ),
      ),
    ).then((value) =>{});
  }

  static cancelProgress(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      useSafeArea: true,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'ProximaNova',
                fontSize: 18,
                color: ColorManager.grad_1
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel_outlined, color: ColorManager.danger,)
            )
          ],
        ),
        content: Text(
            message,
            style: const TextStyle(
              fontFamily: 'ProximaNova',
              fontSize: 14,
                color: ColorManager.grad_1,
              fontWeight: FontWeight.bold
            ),
        ),
      ),
    );
  }
}