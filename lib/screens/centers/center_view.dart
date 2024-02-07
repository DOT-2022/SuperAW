
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AWC/screens/centers/center_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_manager.dart';

class CenterView extends StatelessWidget {
  const CenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CenterViewModel>.reactive(
        viewModelBuilder: () => CenterViewModel(),
        onViewModelReady: (model) async {
          await model.setBuildContext(context);
          await model.loadData();
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ColorManager.medium,
            appBar: AppBar(
              centerTitle: false,
              iconTheme: const IconThemeData(color: ColorManager.light),
              title: const Text(
                  'AW Centers',
                  style: TextStyle(
                    color: ColorManager.light,
                    fontSize: 18,
                    fontFamily: 'ProximaNova'
                  )),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_business_rounded),
                  tooltip: 'Add New Centers',
                  onPressed: () => model.goNext(),
                ),
              ],
              backgroundColor: ColorManager.grad_1,
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[50],
                  ),
                  child: TextField(
                    onChanged: (value) => model.search(value),
                    style: const TextStyle(
                      fontFamily: 'ProximaNova'
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search Centers...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: ListView.builder(
                        itemCount: model.centers.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 6,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.15,
                                  width: double.infinity,
                                  child: (model.centers[index]['image'] != '')
                                      ? Image.memory(model.decodeBase64(model
                                      .centers[index]['image']), fit: BoxFit.cover, )
                                      : Image.asset(
                                        'assets/images/landscape.png',
                                        fit: BoxFit.cover,
                                        opacity: const AlwaysStoppedAnimation(.6),
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.centers[index]['name'],
                                                  overflow: TextOverflow.clip,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    fontFamily: 'ProximaNova'
                                                  ),
                                                ),
                                                Text(
                                                  model.centers[index]['address'],
                                                  overflow: TextOverflow.clip,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'ProximaNova'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Type: ${model.centers[index]['c_type']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'ProximaNova'
                                                  ),
                                                ),
                                                Text(
                                                  'Center ID: ${model.centers[index]['c_id']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'ProximaNova'
                                                  ),
                                                ),
                                                Text(
                                                  'Code: ${model.centers[index]['code']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'ProximaNova'
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text(
                                          'Other Details',
                                          style: TextStyle(
                                              fontFamily: 'ProximaNova'
                                          ),
                                        ),
                                        subtitle: Text(
                                          (model.isExpanded)
                                            ? ''
                                            : 'Click to see more details about this center',
                                          style: const TextStyle(
                                              fontFamily: 'ProximaNova'
                                          ),
                                        ),
                                        tilePadding: const EdgeInsets.only(left:10, right: 10),
                                        childrenPadding: const EdgeInsets.all(10),
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Com Building: ${model.centers[index]['community_building']}',
                                                  style: const TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Center Type: ${model.centers[index]['c_type']}',
                                                  style: const TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Ownership: ${model
                                                      .centers[index]['building_ownership']}',
                                                  style: const TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorManager.grad_1,
                                                      fontFamily: 'ProximaNova'
                                                  ),
                                                  children: [
                                                    const WidgetSpan(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(right: 10.0),
                                                          child: Icon(
                                                            Icons.person_rounded,
                                                            color: ColorManager.lightGrey,
                                                          ),
                                                        ),
                                                        alignment: PlaceholderAlignment.middle
                                                    ),
                                                    TextSpan(
                                                      text: (model.centers[index]['w_name'] != '')
                                                          ? model.centers[index]['w_name']
                                                          : 'Worker Not Assigned',
                                                      style: const TextStyle(
                                                        fontFamily: 'ProximaNova',
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              (model.centers[index]['w_name'] != null)
                                                  ? InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.phone_forwarded_rounded,
                                                  color: ColorManager.grad_10,
                                                ),)
                                                  : const SizedBox(height:0),
                                            ],
                                          ),
                                          // const Divider(),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Text.rich(
                                          //       TextSpan(
                                          //         style: const TextStyle(
                                          //             fontWeight: FontWeight.bold,
                                          //             color: ColorManager.grad_1,
                                          //             fontFamily: 'ProximaNova'
                                          //         ),
                                          //         children: [
                                          //           const WidgetSpan(
                                          //               child: Icon(
                                          //                 Icons.person_rounded,
                                          //                 color: ColorManager.lightGrey,
                                          //               ),
                                          //               alignment: PlaceholderAlignment.middle
                                          //           ),
                                          //           TextSpan(
                                          //             text: (model.centers[index]['h_name'] != ''
                                          //                 || model.centers[index]['w_name'] != null)
                                          //                 ? model.centers[index]['h_name']
                                          //                 : 'Helper Not Assigned',
                                          //           )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     (model.centers[index]['h_name'] != null)
                                          //         ? InkWell(
                                          //       onTap: () {},
                                          //       child: const Icon(
                                          //         Icons.phone_forwarded_rounded,
                                          //         color: ColorManager.grad_10,
                                          //       ),
                                          //     )
                                          //         : const SizedBox(height: 0,),
                                          //   ],
                                          // ),
                                        ],
                                        onExpansionChanged: (val) => model.onExpandClick(val),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () async {
                                              await model.showConfirmationDialog(model
                                                  .centers[index]['id'], model
                                                  .centers[index]['name']);
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              side: const BorderSide(width: 1, color: ColorManager
                                                  .danger),
                                              minimumSize: const Size(120.0, 30.0),
                                              foregroundColor: ColorManager.danger,
                                            ),
                                            child: const Text(
                                              'DELETE',
                                              style: TextStyle(
                                                fontFamily: 'ProximaNova'
                                              ),
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: () async {
                                              await model.editCenter(model.centers[index]);
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              side: const BorderSide(width: 1, color: ColorManager
                                                  .secondary),
                                              minimumSize: const Size(120.0, 30.0),
                                              foregroundColor: ColorManager.secondary,
                                            ),
                                            child: const Text(
                                              'EDIT',
                                              style: TextStyle(
                                                  fontFamily: 'ProximaNova'
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
