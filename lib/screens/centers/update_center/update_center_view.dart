import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AWC/screens/centers/update_center/update_center_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/color_manager.dart';

class UpdateCenterView extends StatelessWidget {
  const UpdateCenterView({super.key, required this.currentCetner});
  final Map<String, dynamic> currentCetner;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateCenterViewModel>.reactive(
        viewModelBuilder: () => UpdateCenterViewModel(),
        onViewModelReady: (model) {
          model.center = currentCetner;
          model.init();
          model.setBuildContext(context);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              iconTheme: const IconThemeData(color: ColorManager.light),
              title: const Text(
                  'Update Center',
                  style: TextStyle(
                      color: ColorManager.light,
                      fontSize: 18,
                      fontFamily: 'ProximaNova'
                  )),
              backgroundColor: ColorManager.grad_1,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.15,
                      width: double.infinity,
                      child:
                      (model.imageLink)
                          ? Image.file(
                        model.imageFile,
                        fit: BoxFit.cover,)
                          : (model.isByteImage)
                            ? Image.memory(model.bytesImage, fit: BoxFit.cover,)
                            : Image.asset('assets/images/landscape.png', fit: BoxFit.contain,),

                    ),
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext ctx) =>
                            buildCupertinoActionSheet(ctx, model),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Center Id: *',
                                    style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    controller: model.cIdCtrl,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    autofocus: true,
                                    style: const TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      hintText: 'Enter 3 Digit ID',
                                      hintStyle: TextStyle(
                                          color: ColorManager.grey,
                                          fontFamily: 'ProximaNova'
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Center Code: *',
                                    style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    controller: model.cCodeCtrl,
                                    keyboardType: TextInputType.number,
                                    maxLength: 11,
                                    style: const TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      hintText: 'Enter 11 Digit Code',
                                      hintStyle: TextStyle(
                                          color: ColorManager.grey,
                                          fontFamily: 'ProximaNova'
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Center Name: *',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: model.cNameCtrl,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            hintText: 'Enter Center Name',
                            hintStyle: TextStyle(
                                color: ColorManager.grey,
                                fontFamily: 'ProximaNova'
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Community Building:',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),

                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'School',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox1,
                                onChanged: (value) => model.setCheckbox1(value!),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Open Space',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox2,
                                onChanged: (value) => model.setCheckbox2(value!),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Panchayat',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox3,
                                onChanged: (value) => model.setCheckbox3(value!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Building Ownership:',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),

                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Owned',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox4,
                                onChanged: (value) => model.setCheckbox4(value!),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Rented',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox5,
                                onChanged: (value) => model.setCheckbox5(value!),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Others',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox6,
                                onChanged: (value) => model.setCheckbox6(value!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Center Type:',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),

                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Pakka',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox7,
                                onChanged: (value) => model.setCheckbox7(value!),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Semi-Pakka',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox8,
                                onChanged: (value) => model.setCheckbox8(value!),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Katcha',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox9,
                                onChanged: (value) => model.setCheckbox9(value!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Latitude:',
                                    style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    controller: model.cLatCtrl,
                                    enabled: false,
                                    style: const TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      counterText: '',
                                      hintText: 'Latitude',
                                      hintStyle: TextStyle(
                                          color: ColorManager.grey,
                                          fontFamily: 'ProximaNova'
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Longitude:',
                                    style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    controller: model.cLongCtrl,
                                    enabled: false,
                                    style: const TextStyle(
                                      fontFamily: 'ProximaNova',
                                    ),
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      counterText: '',
                                      hintText: 'Longitude',
                                      hintStyle: TextStyle(
                                          color: ColorManager.grey,
                                          fontFamily: 'ProximaNova'
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            IconButton.outlined(
                              onPressed: () {
                                model.getCurrentLocation();
                              },
                              alignment: Alignment.centerRight,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: ColorManager.grad_1,
                                side: const BorderSide(
                                    color: ColorManager.grad_1,
                                    width: 1
                                ),
                              ),
                              icon: const Icon(
                                Icons.location_on_rounded,
                              ),)
                          ],
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Address: *',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: model.cAddressCtrl,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          style: const TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            hintText: 'Enter Full Address',
                            hintStyle: TextStyle(
                                color: ColorManager.grey,
                                fontFamily: 'ProximaNova'
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Landmark:',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: model.cLandmarkCtrl,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            hintText: 'Landmark is Optional',
                            hintStyle: TextStyle(
                                color: ColorManager.grey,
                                fontFamily: 'ProximaNova'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: ColorManager.light,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith((states) => ColorManager
                            .light),
                        backgroundColor: MaterialStateProperty.resolveWith((states) => ColorManager.grad_1),
                      ),
                      onPressed: () {
                        // Handle bottom bar button press
                        model.submit();
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    }
  CupertinoActionSheet buildCupertinoActionSheet(BuildContext ctx, UpdateCenterViewModel model) {
    return CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Cancel',
          style: TextStyle(
            fontFamily: 'ProximaNova',
          ),
        ),
        onPressed: () {
          Navigator.pop(ctx);
        },
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text(
            'Choose From Gallery',
            style: TextStyle(
              fontFamily: 'ProximaNova',
            ),
          ),
          onPressed: () {
            model.addImageByGallery();
            Navigator.pop(ctx);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Take Photo',
            style: TextStyle(
              fontFamily: 'ProximaNova',
            ),
          ),
          onPressed: () {
            model.addImageByCamera();
            Navigator.pop(ctx);
          },
        )
      ],
    );
  }
  }
