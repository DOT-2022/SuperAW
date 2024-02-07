import 'package:flutter/material.dart';
import 'package:AWC/screens/workers/worker_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_manager.dart';

class WorkerView extends StatelessWidget {
  const WorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkerViewModel>.reactive(
      onViewModelReady: (model) async {
        await model.setBuildContext(context);
        await model.init();
      },
        viewModelBuilder: () => WorkerViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ColorManager.medium,
            appBar: AppBar(
              centerTitle: false,
              iconTheme: const IconThemeData(color: ColorManager.light),
              title: const Text('AW Workers',
                  style: TextStyle(
                      color: ColorManager.light,
                      fontSize: 18,
                      fontFamily: 'ProximaNova'
                  )),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_add_rounded),
                  tooltip: 'Add New Worker',
                  onPressed: () => model.goNext(),
                ),
              ],
              backgroundColor: ColorManager.grad_1,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                      hintText: 'Search Workers...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount:  model.workers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: ColorManager.grad_1,
                          borderOnForeground: true,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Row(
                              children: [
                                (model.workers[index]['image'] == '')
                                ? CircleAvatar(
                                  backgroundColor: ColorManager.light,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.asset(
                                        'assets/images/avatar.png',
                                      ),
                                  ),
                                )
                                :CircleAvatar(
                                  backgroundColor: ColorManager.grad_1,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.memory(model.decodeBase64(model
                                        .workers[index]['image']), fit: BoxFit.cover, )
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.workers[index]['name'],
                                        style: const TextStyle(
                                          fontFamily: 'ProximaNova',
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.light
                                        ),
                                      ),
                                      Text(
                                        model.workers[index]['contact'],
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova',
                                            color: ColorManager.light
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
                                      Text(
                                        model.workers[index]['c_id'].toString(),
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova',
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.light
                                        ),
                                      ),
                                      Text(
                                        model.workers[index]['c_name'],
                                        style: const TextStyle(
                                            fontFamily: 'ProximaNova',
                                            color: ColorManager.light
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                FittedBox(child: IconButton.filled(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(6),
                                      backgroundColor: MaterialStateProperty.resolveWith((states)
                                      => ColorManager.light)
                                  ),
                                  color: ColorManager.grad_9,
                                  padding: const EdgeInsets.all(0.0),
                                  icon: const Icon(Icons.call),
                                  onPressed: () {
                                    model.callNumber(model.workers[index]['contact']);
                                  },
                                )),

                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: const Icon(
                                            Icons.edit_note_rounded,
                                            color: ColorManager.grad_5,
                                          ),
                                          onTap: () {
                                            model.editWorker(model.workers[index]);
                                          },
                                        ),
                                        const SizedBox(height: 20,),
                                        InkWell(
                                          child: const Icon(
                                            Icons.delete,
                                            color: ColorManager.grad_14,),
                                          onTap: () {
                                            model.showConfirmationDialog(model
                                                .workers[index]['id'],model
                                                .workers[index]['c_name']);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
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
