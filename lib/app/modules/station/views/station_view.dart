import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/station_controller.dart';
import 'station_layout_large.dart';
import 'station_layout_small.dart';

class StationView extends StatelessWidget {
  StationView({Key? key}) : super(key: key);
  final StationController controller = Get.find<StationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "ศส.ปชต.",
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
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
            child: SingleChildScrollView(
              primary: true,
              child: StationLayoutSmall(),
            ),
          ),
          mediumScreen: Container(
            padding: const EdgeInsets.all(defaultPadding),
            // color: Colors.amber,
            child: SingleChildScrollView(
              primary: true,
              child: StationLayoutSmall(),
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
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.only(left: defaultPadding / 2),
                        primary: true,
                        child: Column(
                          children: [
                            const Header(moduleName: "station"),
                            const SizedBox(height: defaultPadding / 2),
                            StationLayoutLarge(),
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
