
import 'package:AWC/models/centers_model.dart';
import 'package:AWC/screens/workers/update_worker/worker_update_view_model.dart';
import 'package:AWC/utils/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class UpdateWorkerView extends StatelessWidget {
  const UpdateWorkerView({super.key, required this.currentWorker});
  final Map<String, dynamic> currentWorker;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateWorkerViewModel>.reactive(
        onViewModelReady: (model) async {
          model.worker = currentWorker;
          await model.setBuildContext(context);
          await model.init();
        },
        viewModelBuilder: () => UpdateWorkerViewModel(),
        builder: (context, model, child){
          return Scaffold(
            backgroundColor: ColorManager.light,
            appBar: AppBar(
              centerTitle: false,
              iconTheme: const IconThemeData(color: ColorManager.light),
              title: const Text(
                  'Update Worker Details',
                  style: TextStyle(
                      color: ColorManager.light,
                      fontFamily: 'ProximaNova',
                      fontSize: 18
                  )),
              backgroundColor: ColorManager.grad_1,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height:10),
                  GestureDetector(
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.15,
                      width: double.infinity,
                      child:
                      (model.imageLink)
                          ? CircleAvatar(
                              backgroundColor: ColorManager.grad_1,
                              child: Container(
                                width: MediaQuery.of(context).size.width*.3,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: (model.isByteImage)
                                ? Image.memory(model.bytesImage, fit: BoxFit.cover,)
                                :Image.file(
                                  model.imageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.contain,),

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
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Worker Name: *',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: model.wNameCtrl,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            hintText: 'Enter Worker Name (Required)',
                            hintStyle: TextStyle(
                                color: ColorManager.grey,
                                fontFamily: 'ProximaNova'
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Worker Contact :',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: model.wContactCtrl,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          style: const TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            hintText: 'Enter 10 Digit Contact No (Required)',
                            hintStyle: TextStyle(
                                color: ColorManager.grey,
                                fontFamily: 'ProximaNova'
                            ),
                          ),
                        ),

                        const Text(
                          'Is worker assigned to multiple centers?',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                title: const Text(
                                  'Yes',
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
                                  'No',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                value: model.checkbox2,
                                onChanged: (value) => model.setCheckbox2(value!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        const Text(
                          'Map Worker to AW Center:',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 5,),
                        (model.isMultiple)
                        ? MultiSelectBottomSheetField(
                          key: model.multiSelectKey,
                          initialChildSize: 0.7,
                          maxChildSize: 0.95,
                          title: const Text("AW Centers List"),
                          buttonText: const Text("Select Centers for Mapping"),
                          buttonIcon: const Icon(Icons.arrow_drop_down_rounded),
                          items: model.allCenters
                              .map((element) => MultiSelectItem(element, element.name))
                              .toList(),
                          searchable: true,
                          onConfirm: (values) {
                            model.addCenters(values);
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            // items: model.initialValues.map((e) => MultiSelectItem(e, e.name)).toList(),
                            onTap: (item) {

                            },
                          ),
                        )
                        : DropdownButton(
                          items: model.centersName.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ProximaNova',
                                    color: ColorManager.dark
                                ),
                              ),
                            );
                          }).toList(),
                          value: model.selectedCenterName,
                          onChanged: (value) => model.updateCenterDetails(value!),
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'ProximaNova',
                              color: ColorManager.grad_1
                          ),
                          isExpanded: true,
                        ),
                        const SizedBox(height: 5,),

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
                      onPressed: () async {
                        // Handle bottom bar button press
                        await model.submit();
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

  CupertinoActionSheet buildCupertinoActionSheet(BuildContext ctx, UpdateWorkerViewModel model) {
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