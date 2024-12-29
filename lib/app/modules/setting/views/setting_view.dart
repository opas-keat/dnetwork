import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/setting_controller.dart';
import 'setting_user_detail.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    // const expandChildrenOnReady = true;
    // TreeViewController? _controller;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
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
                      const Header(moduleName: "setting"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Spacer(flex: 2),
                                    ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.add_sharp,
                                      ),
                                      label: const CustomText(
                                        text: "เพิ่ม",
                                        color: Colors.white,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      onPressed: () {
                                        controller.firstName.text = '';
                                        controller.lastName.text = '';
                                        controller.userName.text = '';
                                        controller.password.text = '';
                                        controller.selectedProvince.value = '';
                                        controller.idCard.text = '';
                                        controller.selectedUserType.value =
                                            'ผู้ใช้งานทั่วไป';
                                        Get.dialog(
                                          SettingUserDetail(),
                                          barrierDismissible: false,
                                        );
                                      },
                                    ),
                                    // const SizedBox(width: defaultPadding / 2),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                Container(
                                  padding:
                                      const EdgeInsets.all(defaultPadding / 2),
                                  height:
                                      MediaQuery.of(context).size.height - 275,
                                  decoration: BoxDecoration(
                                    color: canvasColor,
                                    borderRadius:
                                        BorderRadius.circular(defaultPadding),
                                  ),
                                  child: TreeView.simple(
                                    tree: controller.sampleTree,
                                    showRootNode: true,
                                    expansionBehavior: ExpansionBehavior.none,
                                    shrinkWrap: true,
                                    // scrollController: AutoScrollController(),
                                    // expansionBehavior:
                                    //     ExpansionBehavior.snapToTop,
                                    expansionIndicatorBuilder: (context, node) {
                                      if (node.isRoot) {
                                        return PlusMinusIndicator(
                                          tree: node,
                                          alignment: Alignment.centerLeft,
                                          color: Colors.grey[700],
                                        );
                                      }
                                      return ChevronIndicator.rightDown(
                                        tree: node,
                                        alignment: Alignment.centerLeft,
                                        color: Colors.grey[700],
                                      );
                                    },
                                    indentation: const Indentation(),
                                    builder: (context, node) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: defaultPadding),
                                      child: ListTile(
                                        title: Text(
                                          node.data!.firstName! +
                                              node.data!.lastName!,
                                        ),
                                        // subtitle: Text(
                                        //     node.data?.createdAt.toString() ??
                                        //         "N/A"),
                                        leading: Padding(
                                          padding: const EdgeInsets.only(
                                            top: defaultPadding / 2,
                                          ),
                                          child: Icon(node.data?.icon),
                                        ),
                                      ),
                                    ),
                                    onItemTap: (item) {
                                      // print("Item tapped: ${item.key}");
                                      if (item.data?.type == "root") {
                                        if (item.childrenAsList.isEmpty) {
                                          controller.listProvince();
                                        }
                                        // controller.listUsers(item.key);
                                      } else if (item.data?.type ==
                                          "province") {
                                        if (item.childrenAsList.isEmpty) {
                                          controller.listUsers(item.key);
                                        }
                                        // controller.listUsers(item.key);
                                      } else if (item.data?.type == "user") {
                                        controller.userIdForDelete.value =
                                            item.key;
                                        controller.firstName.text =
                                            item.data!.firstName!;
                                        controller.lastName.text =
                                            item.data!.lastName!;
                                        controller.userName.text =
                                            item.data!.userName!;
                                        controller.password.text =
                                            item.data!.userPassword!;
                                        controller.selectedProvince.value =
                                            item.data!.province!;
                                        controller.idCard.text =
                                            item.data!.idCard!;
                                        controller.selectedUserType.value =
                                            item.data!.userType!;
                                        Get.dialog(
                                          SettingUserDetail(),
                                          barrierDismissible: false,
                                        );
                                        // controller.listUsers(item.key);
                                      }
                                    },
                                    onTreeReady: (c) {
                                      // _controller = c;
                                      // if (expandChildrenOnReady) {
                                      //   _controller?.expandAllChildren(
                                      //       controller.sampleTree);
                                      // }
                                    },
                                  ),
                                ),

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
                          const SizedBox(width: defaultPadding),
                          // Expanded(
                          //   // child: StatisticsChart(),
                          //   child: Container(
                          //     color: Colors.amber,
                          //     width: 10,
                          //     // height: 100,
                          //   ),
                          // ),
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
