import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../../../shared/pdpa_view.dart';
import '../../../shared/utils.dart';
import 'dashboard_layout_large.dart';
import 'dashboard_layout_small.dart';
import 'dashboard_search.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  // DashboardController controller = Get.find<DashboardController>();
  Future<void> _showDialog(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String userPdpa = html.window.sessionStorage["pdpa_check"].toString();
      talker.info("pdpa_check: ${userPdpa}");
      if (userPdpa != "Y") {
        Get.dialog(
          const PdpaView(),
          barrierDismissible: false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _showDialog(context),
      builder: (context, snapshot) => Scaffold(
        appBar: !Responsive.isLargeScreen(context)
            ? AppBar(
                centerTitle: true,
                title: const CustomText(
                  text: "หน้าจอหลัก",
                  color: Colors.white,
                  scale: 0.9,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.dialog(
                        DashboardSearch(),
                        barrierDismissible: false,
                      );
                    },
                    icon: const Icon(
                      Icons.search_sharp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_sharp,
                    ),
                  ),
                ],
              )
            : null,
        drawer: !Responsive.isLargeScreen(context) ? MainDrawer() : null,
        body: SafeArea(
          child: Responsive(
            smallScreen: Container(
              padding: const EdgeInsets.all(defaultPadding / 2),
              // color: Colors.amber,
              child: const SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    DashboardLayoutSmall(),
                  ],
                ),
              ),
            ),
            mediumScreen: Container(
              padding: const EdgeInsets.all(defaultPadding),
              // color: Colors.amber,
              child: const SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    DashboardLayoutSmall(),
                  ],
                ),
              ),
            ),
            largeScreen: Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => MainDrawer(),
                  ),
                ),
                Expanded(
                  flex: Responsive.isLargeScreen(context) ? 6 : 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Container(
                      color: Colors.white,
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(left: defaultPadding / 2),
                          primary: true,
                          child: Column(
                            children: [
                              Header(moduleName: "dashboard"),
                              SizedBox(height: defaultPadding / 2),
                              DashboardLayoutLarge(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: !Responsive.isLargeScreen(context)
    //       ? AppBar(
    //           centerTitle: true,
    //           title: const CustomText(
    //             text: "หน้าจอหลัก",
    //             color: Colors.white,
    //             scale: 0.9,
    //           ),
    //           actions: [
    //             IconButton(
    //               onPressed: () {
    //                 Get.dialog(
    //                   DashboardSearch(),
    //                   barrierDismissible: false,
    //                 );
    //               },
    //               icon: const Icon(
    //                 Icons.search_sharp,
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () {},
    //               icon: const Icon(
    //                 Icons.person_sharp,
    //               ),
    //             ),
    //           ],
    //         )
    //       : null,
    //   drawer: !Responsive.isLargeScreen(context) ? MainDrawer() : null,
    //   body: SafeArea(
    //     child: Responsive(
    //       smallScreen: Container(
    //         padding: const EdgeInsets.all(defaultPadding / 2),
    //         // color: Colors.amber,
    //         child: const SingleChildScrollView(
    //           primary: true,
    //           child: Column(
    //             children: [
    //               DashboardLayoutSmall(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       mediumScreen: Container(
    //         padding: const EdgeInsets.all(defaultPadding),
    //         // color: Colors.amber,
    //         child: const SingleChildScrollView(
    //           primary: true,
    //           child: Column(
    //             children: [
    //               DashboardLayoutSmall(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       largeScreen: Row(
    //         children: [
    //           Expanded(
    //             child: LayoutBuilder(
    //               builder: (context, constraints) => MainDrawer(),
    //             ),
    //           ),
    //           Expanded(
    //             flex: Responsive.isLargeScreen(context) ? 6 : 1,
    //             child: LayoutBuilder(
    //               builder: (context, constraints) => Container(
    //                 color: Colors.white,
    //                 child: const Align(
    //                   alignment: Alignment.topCenter,
    //                   child: SingleChildScrollView(
    //                     padding: EdgeInsets.only(left: defaultPadding / 2),
    //                     primary: true,
    //                     child: Column(
    //                       children: [
    //                         Header(moduleName: "dashboard"),
    //                         SizedBox(height: defaultPadding / 2),
    //                         DashboardLayoutLarge(),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   appBar: !Responsive.isLargeScreen(context)
    //       ? AppBar(
    //           centerTitle: true,
    //           title: const CustomText(
    //             text: "หน้าจอหลัก",
    //             color: Colors.white,
    //           ),
    //           actions: [
    //             IconButton(
    //               onPressed: () {},
    //               icon: const Icon(
    //                 Icons.search_sharp,
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () {},
    //               icon: const Icon(
    //                 Icons.person_sharp,
    //               ),
    //             ),
    //           ],
    //         )
    //       : null,
    //   drawer: !Responsive.isLargeScreen(context) ? const MainDrawer() : null,
    //   body: SafeArea(
    //     child: Responsive(
    //       smallScreen: Container(
    //         padding: const EdgeInsets.all(defaultPadding / 2),
    //         // color: Colors.amber,
    //         child: const SingleChildScrollView(
    //           primary: true,
    //           child: Column(
    //             children: [
    //               DashboardLayoutSmall(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       mediumScreen: Container(
    //         padding: const EdgeInsets.all(defaultPadding),
    //         // color: Colors.amber,
    //         child: const SingleChildScrollView(
    //           primary: true,
    //           child: Column(
    //             children: [
    //               DashboardLayoutSmall(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       largeScreen: Row(
    //         children: [
    //           Expanded(
    //             child: LayoutBuilder(
    //               builder: (context, constraints) => const MainDrawer(),
    //             ),
    //           ),
    //           Expanded(
    //             flex: Responsive.isLargeScreen(context) ? 6 : 1,
    //             child: LayoutBuilder(
    //               builder: (context, constraints) => Container(
    //                 color: Colors.white,
    //                 child: const Align(
    //                   alignment: Alignment.topCenter,
    //                   child: SingleChildScrollView(
    //                     padding:
    //                         EdgeInsets.only(left: defaultPadding / 2),
    //                     primary: true,
    //                     child: Column(
    //                       children: [
    //                         Header(moduleName: "หน้าจอหลัก"),
    //                         SizedBox(height: defaultPadding / 2),
    //                         DashboardLayoutLarge(),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
