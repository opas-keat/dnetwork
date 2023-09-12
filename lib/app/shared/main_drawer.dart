import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/module.dart';
import '../modules/address/controllers/address_controller.dart';
import 'constant.dart';
import 'custom_text.dart';
import 'utils.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});
  final AddressController addressController = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: defaultPadding / 2),
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
                  return (window.sessionStorage["roles"]
                              .toString()
                              .contains('user') &&
                          listModule[index].nameEn.contains('setting'))
                      ? Container()
                      : Material(
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
                              // talker.debug("drawer: ${listModule[index].nameEn}");
                              addressController.selectedProvince.value = '';
                              addressController.selectedAmphure.value = '';
                              addressController.selectedTambol.value = '';
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
