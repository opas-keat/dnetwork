import 'package:flutter/material.dart';
import 'package:frontend/app/shared/utils.dart';
import 'package:get/get.dart';

import '../../responsive.dart';
import '../data/models/module.dart';
import '../modules/address/controllers/address_controller.dart';
import '../modules/budget/views/budget_search.dart';
import '../modules/commiss/views/commiss_search.dart';
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
        SearchButton(moduleName: moduleName),
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
  // addressController.selectedProvince.value = "0|";
  // addressController.update();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        addressController.selectedProvince.value = "0|";
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
          Image.network(
            "assets/images/avatar.png",
            height: 38,
          ),
          if (!Responsive.isSmallScreen(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("ผู้ดูแลระบบ"),
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
