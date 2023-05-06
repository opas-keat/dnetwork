import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../responsive.dart';
import '../data/models/module.dart';
import 'constant.dart';
import 'custom_text.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child:
                Center(child: Image.network('assets/icons/logo-300x300.png')),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listModule.length,
              itemBuilder: (context, index) {
                return Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    hoverColor: primaryColor.withOpacity(0.2),
                    leading: Icon(
                      listModule[index].icon,
                    ),
                    // title: Text(listModule[index].nameTH,
                    //     style: TextStyle(fontSize: 14)),
                    title: CustomText(
                      text: listModule[index].nameTH,
                      scale: 0.9,
                    ),
                    onTap: () {
                      talker.debug("edit: ${listModule[index].nameEn}");
                      Get.toNamed(listModule[index].url);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
