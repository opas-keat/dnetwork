import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/lectuter_controller.dart';
import 'lectuter_layout_large.dart';
import 'lectuter_layout_small.dart';
import 'lectuter_search.dart';

class LectuterView extends StatelessWidget {
  LectuterView({super.key});
  final LectuterController controller = Get.find<LectuterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "วิทยากรประชาธิปไตย",
                color: Colors.white,
                scale: 0.9,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.MANAGE_LECTUTER);
                  },
                  icon: const Icon(
                    Icons.add_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      LectuterSearch(),
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
                  LectuterLayoutSmall(),
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
                  LectuterLayoutSmall(),
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
                            Header(moduleName: "lectuter"),
                            SizedBox(height: defaultPadding / 2),
                            LectuterLayoutLarge(),
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
    );
  }
}
