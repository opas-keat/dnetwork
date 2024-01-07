import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/address_controller.dart';

class AddressView extends StatelessWidget {
  AddressView({
    super.key,
    this.showProvince = true,
    this.showAmphure = true,
    this.showTambol = true,
    this.showPostCode = true,
  });
  final AddressController controller = Get.put(AddressController());

  final bool showProvince;
  final bool showAmphure;
  final bool showTambol;
  final bool showPostCode;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showProvince) ...[
          Wrap(
            direction: Axis.horizontal,
            children: [
              CustomText(
                text: "จังหวัด",
                color: Colors.black87.withOpacity(.9),
              ),
              CustomText(
                text: "*",
                color: Colors.red.withOpacity(.9),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          // ),
          Obx(
            () => InputDecorator(
              decoration: const InputDecoration(
                isCollapsed: true,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  elevation: 0,
                  // value: null,
                  // value: controller.provinceList.obs.value[0],
                  value: controller.selectedProvince.value,
                  isDense: true,
                  onChanged: (newValue) {
                    controller.updateSelectedProvince(newValue!, showAmphure);
                  },
                  items: controller.provinceList.obs.value.map((item) {
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
        ],
        if (showAmphure) ...[
          const SizedBox(height: defaultPadding),
          Wrap(
            direction: Axis.horizontal,
            children: [
              CustomText(
                text: "อำเภอ/เขต",
                color: Colors.black87.withOpacity(.9),
              ),
              CustomText(
                text: "*",
                color: Colors.red.withOpacity(.9),
              ),
            ],
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
                  value: controller.selectedAmphure.value,
                  isDense: true,
                  onChanged: (newValue) {
                    controller.updateSelectedAmphure(newValue!);
                  },
                  items: controller.amphureList.obs.value.map((item) {
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
        ],
        // const SizedBox(height: defaultPadding / 2),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        // ),
        if (showTambol) ...[
          const SizedBox(height: defaultPadding),
          Wrap(
            direction: Axis.horizontal,
            children: [
              CustomText(
                text: "ตำบล/แขวง",
                color: Colors.black87.withOpacity(.9),
              ),
              CustomText(
                text: "*",
                color: Colors.red.withOpacity(.9),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          // ),
          Obx(
            () => InputDecorator(
              decoration: const InputDecoration(
                isCollapsed: true,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  elevation: 0,
                  value: controller.selectedTambol.value,
                  isDense: true,
                  onChanged: (newValue) {
                    controller.updateSelectedTambol(newValue!);
                  },
                  items: controller.tambolList.obs.value.map((item) {
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
        ],
        const SizedBox(height: defaultPadding),
        if (showPostCode) ...[
          CustomText(
            text: "รหัสไปรษณีย์",
            color: Colors.black87.withOpacity(.9),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextFormField(
            keyboardType: TextInputType.number,
          ),
        ]
      ],
    );
  }
}
