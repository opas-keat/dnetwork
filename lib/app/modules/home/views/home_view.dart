import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/app/shared/constant.dart';

import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../responsive.dart';
import '../../../data/models/module.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: Responsive.isSmallScreen(context)
          ? AppBar(
              backgroundColor: primaryColor,
              title: Text(getModuleByIndex(_controller.selectedIndex).nameTH),
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
          ? MainSidebar(controller: _controller)
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (!Responsive.isSmallScreen(context))
              MainSidebar(controller: _controller),
            Expanded(
              child: Center(
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainSidebar extends StatelessWidget {
  const MainSidebar({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);
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
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.28),
          //     blurRadius: 30,
          //   )
          // ],
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
              icon: Icons.home,
              label: module.nameTH,
              onTap: () {
                debugPrint(module.nameEn);
              },
            ),
          )
          .toList(),
      // items: listModule.forEach((element) {
      //   return SidebarXItem(
      //     icon: Icons.home,
      //     label: 'Home',
      //     onTap: () {
      //       debugPrint('Home');
      //     },
      //   );
      // }),
      // items: [
      //   SidebarXItem(
      //     icon: Icons.home,
      //     label: 'Home',
      //     onTap: () {
      //       debugPrint('Home');
      //     },
      //   ),
      //   const SidebarXItem(
      //     icon: Icons.search,
      //     label: 'Search',
      //   ),
      //   const SidebarXItem(
      //     icon: Icons.people,
      //     label: 'People',
      //   ),
      //   const SidebarXItem(
      //     icon: Icons.favorite,
      //     label: 'Favorites',
      //   ),
      //   const SidebarXItem(
      //     iconWidget: FlutterLogo(size: 20),
      //     label: 'Flutter',
      //   ),
      // ],
    );
  }
}
