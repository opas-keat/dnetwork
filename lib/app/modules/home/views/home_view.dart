import 'package:flutter/material.dart';
import 'package:frontend/app/modules/home/controllers/home_controller.dart';
import 'package:frontend/app/shared/constant.dart';

import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../responsive.dart';
import '../../../data/models/module.dart';
import '../../admin/controllers/admin_controller.dart';
import '../../commiss/controllers/commiss_controller.dart';
import '../../commiss/views/commiss_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../lectuter/controllers/lectuter_controller.dart';
import '../../lectuter/views/lectuter_view.dart';
import '../../setting/views/setting_view.dart';
import '../../station/controllers/station_controller.dart';
import '../../station/views/station_view.dart';
import '../../villagehosty/controllers/villagehosty_controller.dart';
import '../../villagehosty/views/villagehosty_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  HomeController homeController = Get.find<HomeController>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: Responsive.isSmallScreen(context)
          ? AppBar(
              backgroundColor: primaryColor,
              title:
                  Obx(() => Text(homeController.selectedModule.value.nameTH)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _controller.setExtended(true);
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
          : null,
      drawer: Responsive.isSmallScreen(context)
          ? SidebarX(
              controller: _controller,
              theme: SidebarXTheme(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                hoverColor: scaffoldBackgroundColor,
                textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                selectedTextStyle: const TextStyle(color: Colors.white),
                itemTextPadding: const EdgeInsets.only(left: 30),
                selectedItemTextPadding: const EdgeInsets.only(left: 30),
                // itemDecoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(color: canvasColor),
                // ),
                selectedItemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: actionColor.withOpacity(0.37),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      primaryColor,
                      accentColor,
                    ],
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 20,
                ),
              ),
              extendedTheme: const SidebarXTheme(
                width: 200,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
              ),
              footerDivider: divider,
              headerBuilder: (context, extended) {
                return SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.network('assets/images/avatar.png'),
                  ),
                );
              },
              items: listModule
                  .map(
                    (module) => SidebarXItem(
                      icon: module.icon,
                      label: module.nameTH,
                      onTap: () {
                        // debugPrint(module.nameEn);
                        // homeController.title.value = module.nameTH;
                        homeController.selectedModule.value = module;
                        _key.currentState?.closeDrawer();
                      },
                    ),
                  )
                  .toList(),
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isSmallScreen(context))
              MainSidebar(controller: _controller),
            Expanded(
              child: MainScreen(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);
  AdminController adminController = Get.put(AdminController());
  StationController stationController = Get.put(StationController());
  CommissController commissController = Get.put(CommissController());
  LectuterController lectuterController = Get.put(LectuterController());
  VillagehostyController villageController = Get.put(VillagehostyController());

  final SidebarXController controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final pageTitle = getModuleByIndex(controller.selectedIndex).nameTH;
            switch (controller.selectedIndex) {
              case 0:
                return DashboardView();
              case 1:
                stationController.onInit();
                return StationView();
              case 2:
                commissController.onInit();
                return CommissView();
              case 3:
                lectuterController.onInit();
                return LectuterView();
              case 4:
                villageController.onInit();
                return VillagehostyView();
              case 5:
                return SettingView();
              default:
                // adminController.onInit();
                return DashboardView();
            }
          }),
    );
  }
}

class MainSidebar extends StatelessWidget {
  MainSidebar({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);
  HomeController homeController = Get.find<HomeController>();
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        // itemDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(color: canvasColor),
        // ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor,
              accentColor,
            ],
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network('assets/images/avatar.png'),
          ),
        );
      },
      items: listModule
          .map(
            (module) => SidebarXItem(
              icon: module.icon,
              label: module.nameTH,
              onTap: () {
                // debugPrint(module.nameEn);
                // homeController.title.value = module.nameTH;
                homeController.selectedModule.value = module;
              },
            ),
          )
          .toList(),
    );
  }
}
