import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/setting_controller.dart';

class SettingUserDetail extends StatelessWidget {
  SettingUserDetail({
    super.key,
  });
  final SettingController controller = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "ผู้ใช้งาน",
        color: Colors.black87.withOpacity(.9),
      ),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 480,
        height: 640,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                controller.selectedProvince.value == ""
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "ชื่อเข้าใช้งาน",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
                            controller: controller.userName,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: defaultPadding),
                          CustomText(
                            text: "รหัสผ่าน",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
                            controller: controller.password,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: defaultPadding),
                        ],
                      )
                    : const SizedBox(height: 1),
                CustomText(
                  text: "ชื่อ",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                TextFormField(
                  controller: controller.firstName,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "นามสกุล",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                TextFormField(
                  controller: controller.lastName,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "รหัสยืนยัน 2 ขั้นตอน",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                TextFormField(
                  controller: controller.idCard,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "จังหวัด",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                Obx(
                  () => InputDecorator(
                    decoration: const InputDecoration(
                      isCollapsed: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        elevation: 0,
                        value: controller.selectedProvince.value,
                        isDense: true,
                        onChanged: (newValue) {
                          controller.selectedProvince.value = newValue!;
                        },
                        items: controller.provinceList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              textScaler: const TextScaler.linear(0.9),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "ประเภทผู้ใช้งาน",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                Obx(
                  () => InputDecorator(
                    decoration: const InputDecoration(
                      isCollapsed: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        elevation: 0,
                        value: controller.selectedUserType.value,
                        isDense: true,
                        onChanged: (newValue) {
                          controller.selectedUserType.value = newValue!;
                        },
                        items: controller.userTypeList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              textScaler: const TextScaler.linear(0.9),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                final result = await controller.delete();
                if (result) {
                  controller.sampleTree
                      .elementAt(controller.selectedProvince.value)
                      .clear();
                  controller.listUsers(controller.selectedProvince.value);
                }
                Get.back();
              },
              child: const CustomText(
                text: "ลบ",
                color: Colors.red,
                weight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 2),
            TextButton(
              onPressed: () async {
                var result = false;
                if (controller.userIdForDelete.value == "") {
                  // Get.snackbar(
                  //   "กรุณากรอกชื่อ",
                  //   "กรุณากรอกชื่อ",
                  //   snackPosition: SnackPosition.BOTTOM,
                  // );
                  // return;
                  result = await controller.save();
                } else {
                  result = await controller.edit();
                }
                if (result) {
                  controller.sampleTree
                      .elementAt(controller.selectedProvince.value)
                      .clear();
                  controller.listUsers(controller.selectedProvince.value);
                  controller.firstName.text = '';
                  controller.lastName.text = '';
                  controller.userName.text = '';
                  controller.password.text = '';
                  controller.selectedProvince.value = '';
                  controller.idCard.text = '';
                  controller.selectedUserType.value = 'ผู้ใช้งานทั่วไป';
                  Get.back();
                }
              },
              child: const CustomText(
                text: "บันทึก",
                color: Colors.green,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: defaultPadding * 2),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                text: "ปิด",
                color: Colors.black87.withOpacity(.9),
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
