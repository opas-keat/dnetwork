import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/reportproblem_controller.dart';

class ReportproblemView extends StatelessWidget {
  ReportproblemView({Key? key}) : super(key: key);
  ReportproblemController controller = Get.find<ReportproblemController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(
              child: MainDrawer(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Header(moduleName: "แจ้งปัญหาการใช้งาน"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "กกต ส่วนกลาง",
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    const Spacer(flex: 2),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.insert_drive_file_sharp,
                                      ),
                                      label: const Text('รายงาน'),
                                    ),
                                    const SizedBox(width: defaultPadding / 2),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.add_sharp,
                                      ),
                                      label: const Text('เพิ่ม'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                // Spacer(),
                                // const Responsive(
                                //   smallScreen: InfoCard(
                                //     crossAxisCount: 2,
                                //     childAspectRatio: 2.0,
                                //   ),
                                //   largeScreen: InfoCard(
                                //     childAspectRatio: 2.2,
                                //   ),
                                // ),
                                // const SizedBox(height: defaultPadding),
                                // StatisticsDashboard(),
                                // Spacer(),
                              ],
                            ),
                          ),
                          Expanded(
                            // child: StatisticsChart(),
                            child: Container(
                              color: Colors.amber,
                              // height: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // final ScrollController _scrollController = ScrollController();
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
  //     child: GetBuilder<ReportproblemController>(
  //         init: controller,
  //         builder: (controller) {
  //           // loading
  //           if (controller.isLoading.value) {
  //             return Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: defaultPadding * 2),
  //               child: Center(
  //                 child: const CircularProgressIndicator().reactive(),
  //               ),
  //             );
  //           }
  //           return Row(
  //             children: [
  //               Expanded(flex: 1, child: Container()),
  //               Expanded(
  //                 flex: 8,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const SizedBox(height: defaultPadding * 2),
  //                     CustomText(
  //                       text: "การทำงาน",
  //                       size: 20,
  //                       color: Colors.black87.withOpacity(.9),
  //                     ),
  //                     const SizedBox(height: defaultPadding / 2),
  //                     InputDecorator(
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(
  //                           borderRadius:
  //                               BorderRadius.circular(defaultPadding / 2),
  //                           borderSide: const BorderSide(
  //                               color: Colors.black87, width: 2),
  //                         ),
  //                       ),
  //                       child: DropdownButtonHideUnderline(
  //                         child: DropdownButton<String>(
  //                           elevation: 0,
  //                           value: controller.currentModuleSelected.value,
  //                           isDense: true,
  //                           items: optionModuleSelected.entries.map((item) {
  //                             return DropdownMenuItem<String>(
  //                               value: item.key,
  //                               child: Text(
  //                                 item.value,
  //                                 style: TextStyle(
  //                                   color: Colors.grey.shade700,
  //                                   fontSize: 18,
  //                                 ),
  //                               ),
  //                             );
  //                           }).toList(),
  //                           onChanged: (newValue) {
  //                             controller.updateModuleSelected(newValue!);
  //                           },
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: defaultPadding),
  //                     CustomText(
  //                       text: "รายละเอียด",
  //                       size: 20,
  //                       color: Colors.black87.withOpacity(.9),
  //                     ),
  //                     const SizedBox(height: defaultPadding / 2),
  //                     TextFormField(
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: 4,
  //                       decoration: InputDecoration(
  //                         fillColor: Colors.white.withOpacity(.2),
  //                         filled: true,
  //                         border: OutlineInputBorder(
  //                           borderRadius:
  //                               BorderRadius.circular(defaultPadding / 2),
  //                           borderSide: const BorderSide(
  //                               color: Colors.black87, width: 2),
  //                         ),
  //                         // hintText: 'Enter a search term',
  //                       ),
  //                     ),
  //                     const SizedBox(height: defaultPadding),
  //                     Center(
  //                       child: CustomFlatButton(
  //                         color: primaryColor,
  //                         overlayColor: primaryLightColor,
  //                         padding: const EdgeInsets.all(defaultPadding),
  //                         isWrapped: true,
  //                         label: 'บันทึก',
  //                         onPressed: () {},
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Expanded(flex: 1, child: Container()),
  //             ],
  //           );
  //         }),
  //   );
  // }
}
