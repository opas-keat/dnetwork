import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../data/models/module.dart';
import 'constant.dart';
import 'custom_text.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
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
                      horizontalTitleGap: defaultPadding / 4,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2,
                      ),
                      hoverColor: primaryColor.withOpacity(0.2),
                      leading: Icon(
                        listModule[index].icon,
                      ),
                      title: CustomText(
                        text: listModule[index].nameTH,
                        scale: 0.8,
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
      ),
    );
  }
}
