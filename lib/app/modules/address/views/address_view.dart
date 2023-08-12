import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/address_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/address_controller.dart';

class AddressView extends StatelessWidget {
  AddressView({
    Key? key,
    this.showProvince = true,
    this.showAmphure = true,
    this.showTambol = true,
    this.showPostCode = true,
  }) : super(key: key);
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
          CustomText(
            text: "จังหวัด",
            color: Colors.black87.withOpacity(.9),
          ),
          const SizedBox(height: defaultPadding / 2),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     fillColor: Colors.white.withOpacity(.2),
          //     filled: true,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(defaultPadding / 2),
          //       borderSide: const BorderSide(color: Colors.black87, width: 2),
          //     ),
          //     isCollapsed: true,
          //     contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 12),
          //   ),
          // ),
          Obx(() => InputDecorator(
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(.8),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultPadding / 2),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1),
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    elevation: 0,
                    // value: null,
                    // value: controller.provinceList.obs.value[0],
                    value: controller.selectedProvince.value,
                    isDense: true,
                    onChanged: (newValue) {
                      controller.updateSelectedProvince(newValue!);
                    },
                    items: controller.provinceList.obs.value.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.split('|').last,
                          textScaleFactor: 0.9,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )),
        ],
        if (showAmphure) ...[
          const SizedBox(height: defaultPadding),
          CustomText(
            text: "อำเภอ",
            color: Colors.black87.withOpacity(.9),
          ),
          const SizedBox(height: defaultPadding / 2),
          Obx(() => InputDecorator(
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(.8),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultPadding / 2),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1),
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
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
                          item.split('|').last,
                          textScaleFactor: 0.9,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )),
        ],
        // const SizedBox(height: defaultPadding / 2),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   decoration: InputDecoration(
        //     fillColor: Colors.white.withOpacity(.2),
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(defaultPadding / 2),
        //       borderSide: const BorderSide(color: Colors.black87, width: 2),
        //     ),
        //     isCollapsed: true,
        //     contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 12),
        //   ),
        // ),
        if (showTambol) ...[
          const SizedBox(height: defaultPadding),
          CustomText(
            text: "ตำบล",
            color: Colors.black87.withOpacity(.9),
          ),
          const SizedBox(height: defaultPadding / 2),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     fillColor: Colors.white.withOpacity(.2),
          //     filled: true,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(defaultPadding / 2),
          //       borderSide: const BorderSide(color: Colors.black87, width: 2),
          //     ),
          //     isCollapsed: true,
          //     contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 12),
          //   ),
          // ),
          Obx(() => InputDecorator(
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(.8),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultPadding / 2),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1),
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
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
                          item.split('|').last,
                          textScaleFactor: 0.9,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )),
        ],
        const SizedBox(height: defaultPadding),
        if (showPostCode) ...[
          CustomText(
            text: "รหัสไปรษณีย์",
            color: Colors.black87.withOpacity(.9),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Colors.white.withOpacity(.2),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultPadding / 2),
                borderSide: const BorderSide(color: Colors.black87, width: 2),
              ),
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
            ),
          ),
        ]
      ],
    );
  }
}
