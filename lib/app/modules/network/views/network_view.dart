import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/network_controller.dart';
import 'network_layout_large.dart';
import 'network_layout_small.dart';
import 'network_search.dart';

class NetworkView extends GetView<NetworkController> {
  const NetworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "ภาคีเครือข่าย",
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.MANAGE_NETWORK);
                  },
                  icon: const Icon(
                    Icons.add_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      NetworkSearch(),
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
                  NetworkLayoutSmall(),
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
                  NetworkLayoutSmall(),
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
                            Header(moduleName: "network"),
                            SizedBox(height: defaultPadding / 2),
                            NetworkLayoutLarge(),
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
