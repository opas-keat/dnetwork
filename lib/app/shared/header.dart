import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:frontend/app/api/api.dart';
import 'package:frontend/app/shared/utils.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../responsive.dart';
import '../data/models/module.dart';
import '../modules/address/controllers/address_controller.dart';
import '../modules/budget/views/budget_search.dart';
import '../modules/commiss/views/commiss_search.dart';
import '../modules/lectuter/views/lectuter_search.dart';
import '../modules/member/views/member_search.dart';
import '../modules/network/views/network_search.dart';
import '../modules/station/views/station_search.dart';
import '../modules/training/views/training_search.dart';
import '../modules/villagehosty/views/village_search.dart';
import 'constant.dart';
import 'custom_text.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.moduleName = "",
  });

  final String moduleName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: getModuleByNameEn(moduleName).nameTH,
          weight: FontWeight.bold,
        ),
        const Spacer(flex: 2),
        // const Expanded(child: SearchField()),
        // SearchButton(moduleName: moduleName),
        const ProfileCard(),
      ],
    );
  }
}

class SearchButton extends StatelessWidget {
  SearchButton({
    super.key,
    this.moduleName = "",
  });

  final String moduleName;
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        addressController.selectedProvince.value = "";
        addressController.update();
        switch (moduleName) {
          case "station":
            Get.dialog(
              StationSearch(),
              barrierDismissible: false,
            );
            break;
          case "commiss":
            Get.dialog(
              CommissSearch(),
              barrierDismissible: false,
            );
            break;
          case "member":
            Get.dialog(
              MemberSearch(),
              barrierDismissible: false,
            );
            break;
          case "network":
            Get.dialog(
              NetworkSearch(),
              barrierDismissible: false,
            );
            break;
          case "training":
            Get.dialog(
              TrainingSearch(),
              barrierDismissible: false,
            );
            break;
          case "village":
            Get.dialog(
              VillageSearch(),
              barrierDismissible: false,
            );
            break;
          case "lectuter":
            Get.dialog(
              LectuterSearch(),
              barrierDismissible: false,
            );
            break;
          case "budget":
            Get.dialog(
              BudgetSearch(),
              barrierDismissible: false,
            );
            break;
          case "budget":
            Get.dialog(
              BudgetSearch(),
              barrierDismissible: false,
            );
            break;
          default:
            talker.debug("search.");
        }
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_sharp,
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        // color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          TextButton(
            child: const CustomText(
              text: "คู่มือ",
              color: Colors.blue,
              scale: 1.2,
              weight: FontWeight.bold,
            ),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: CustomText(
                    text: "คู่มือ",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  content: SizedBox(
                    width: 320,
                    // height: 480,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          QrImageView(
                            data:
                                '${Api.baseUrl + Api.ectApiContext + Api.ectApiVersion}/file_attach/manual',
                            version: QrVersions.auto,
                            size: 160,
                            gapless: false,
                          ),
                          const SizedBox(height: defaultPadding),
                          TextButton(
                            child: const CustomText(
                              text: "Download",
                              color: Colors.blue,
                              scale: 1.2,
                              weight: FontWeight.bold,
                            ),
                            onPressed: () {
                              html.window.open(
                                  '${Api.baseUrl + Api.ectApiContext + Api.ectApiVersion}/file_attach/manual',
                                  "คู่มือ");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("ปิด"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            },
          ),
          const SizedBox(width: defaultPadding),
          Image.network(
            "assets/images/avatar.png",
            height: 38,
          ),
          if (!Responsive.isSmallScreen(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: CustomText(
                text: html.window.sessionStorage["profile"].toString(),
              ),
            ),
          // Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "ค้นหา",
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(Icons.search_sharp),
          ),
        ),
      ),
    );
  }
}
