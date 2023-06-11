import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/setting_controller.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key}) : super(key: key);
  final SettingController controller = Get.put(SettingController());
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
                      const Header(moduleName: "ตั้งค่า"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const CustomText(
                                //       text: "กกต ส่วนกลาง",
                                //       weight: FontWeight.bold,
                                //       size: 18,
                                //     ),
                                //     const Spacer(flex: 2),
                                //     ElevatedButton.icon(
                                //       onPressed: () {},
                                //       style: ElevatedButton.styleFrom(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: defaultPadding,
                                //             horizontal: defaultPadding / 2),
                                //       ),
                                //       icon: const Icon(
                                //         Icons.insert_drive_file_sharp,
                                //       ),
                                //       label: const Text('รายงาน'),
                                //     ),
                                //     const SizedBox(width: defaultPadding / 2),
                                //     ElevatedButton.icon(
                                //       onPressed: () {},
                                //       style: ElevatedButton.styleFrom(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: defaultPadding,
                                //             horizontal: defaultPadding / 2),
                                //       ),
                                //       icon: const Icon(
                                //         Icons.add_sharp,
                                //       ),
                                //       label: const Text('เพิ่ม'),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: defaultPadding),
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
  // final List<Item> _data = generateItems(8);
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SizedBox(height: defaultPadding),
  //         SizedBox(
  //           height: 50,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                 child: TextFormField(
  //                   textInputAction: TextInputAction.next,
  //                   cursorColor: primaryColor,
  //                   // controller: _textEmail,
  //                   decoration: const InputDecoration(
  //                     hintText: 'ค้นหา',
  //                     prefixIcon: Icon(Icons.search_sharp),
  //                   ),
  //                   // validator: (value) => validateNotEmpty(value!, 'Your Email'),
  //                 ),
  //               ),
  //               const SizedBox(width: defaultPadding),
  //               CustomFlatButton(
  //                 color: primaryColor,
  //                 overlayColor: primaryLightColor,
  //                 padding: const EdgeInsets.all(defaultPadding),
  //                 isWrapped: true,
  //                 label: 'ค้นหา',
  //                 onPressed: () {},
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: defaultPadding),
  //         Obx(() => ExpansionPanelList(
  //               expansionCallback: (int index, bool isExpanded) {
  //                 controller.provinceSettingList[index].isExpanded.value =
  //                     !isExpanded;
  //               },
  //               children:
  //                   controller.provinceSettingList.map<ExpansionPanel>((ps) {
  //                 return ExpansionPanel(
  //                   headerBuilder: (BuildContext context, bool isExpanded) {
  //                     return ListTile(
  //                       title: Text(ps.name!),
  //                     );
  //                   },
  //                   body: ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: ps.users!.length,
  //                     itemBuilder: (_, index) {
  //                       return ListTile(
  //                         title: Text(ps.users[index].name),
  //                         trailing: Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             IconButton(
  //                               icon: const Icon(Icons.edit),
  //                               tooltip: 'แก้ไข',
  //                               onPressed: () {
  //                                 talker.debug("edit: ${ps.users[index].name}");
  //                               },
  //                             ),
  //                             const SizedBox(width: defaultPadding),
  //                             IconButton(
  //                               icon: const Icon(Icons.delete),
  //                               tooltip: 'ลบ',
  //                               onPressed: () {
  //                                 talker
  //                                     .debug("delete: ${ps.users[index].name}");
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                         onTap: () {
  //                           // setState(() {
  //                           //   _data.removeWhere((Item currentItem) => item == currentItem);
  //                           // });
  //                         },
  //                       );
  //                     },
  //                   ),
  //                   isExpanded: ps.isExpanded!.value,
  //                   canTapOnHeader: false,
  //                 );
  //               }).toList(),
  //             )),
  //       ],
  //     ),
  //   );
  // }
}
