import 'package:flutter/material.dart';
import 'package:frontend/app/data/models/provinces.dart';
import 'package:get/get.dart';

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
          InputDecorator(
            decoration: InputDecoration(
              fillColor: Colors.white.withOpacity(.8),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultPadding / 2),
                borderSide: const BorderSide(color: Colors.black54, width: 1),
              ),
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Province>(
                elevation: 0,
                value: controller.provinceList.obs.value[0],
                isDense: true,
                onChanged: (newValue) {
                  // controller.updatePaymentChannel(newValue!);
                },
                items: controller.provinceList.obs.value.map((item) {
                  return DropdownMenuItem<Province>(
                    value: item,
                    child: Text(
                      item.pName!,
                      textScaleFactor: 0.9,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
        // Obx(
        //   () => InputDecorator(
        //     decoration: InputDecoration(
        //       border: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.blue.shade900),
        //       ),
        //       // helperText: 'การจ่ายเงิน',
        //     ),
        //     child: DropdownButtonHideUnderline(
        //       child: DropdownButton<Province>(
        //         elevation: 0,
        //         value: controller.selectedProvince.value,
        //         isDense: true,
        //         // menuMaxHeight: 400,
        //         style: const TextStyle(
        //           fontSize: 18,
        //         ),
        //         onChanged: (newValue) {
        //           // controller.updatePaymentChannel(newValue!);
        //         },
        //         items: listProvince.map((item) {
        //           return DropdownMenuItem<Province>(
        //             value: item,
        //             child: Text(
        //               item.name!,
        //               style: TextStyle(
        //                 color: Colors.grey.shade700,
        //                 // fontSize: 18,
        //               ),
        //             ),
        //           );
        //         }).toList(),
        //       ),
        //     ),
        //   ),
        // ),
        // DropdownButton(
        //   items: listProvince
        //       .map<DropdownMenuItem<Province>>(
        //         (province) => DropdownMenuItem(
        //           value: province,
        //           child: Text(
        //             province.name!,
        //           ),
        //         ),
        //       )
        //       .toList(),

        //   onChanged: (value) {},
        // ),
        if (showAmphure) ...[
          const SizedBox(height: defaultPadding),
          CustomText(
            text: "อำเภอ",
            color: Colors.black87.withOpacity(.9),
          ),
          const SizedBox(height: defaultPadding / 2),
          InputDecorator(
            decoration: InputDecoration(
              fillColor: Colors.white.withOpacity(.8),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultPadding / 2),
                borderSide: const BorderSide(color: Colors.black54, width: 1),
              ),
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Amphure>(
                elevation: 0,
                value: controller.amphureList.obs.value[0],
                isDense: true,
                onChanged: (newValue) {
                  // controller.updatePaymentChannel(newValue!);
                },
                items: controller.amphureList.obs.value.map((item) {
                  return DropdownMenuItem<Amphure>(
                    value: item,
                    child: Text(
                      item.aName!,
                      textScaleFactor: 0.9,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
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
          InputDecorator(
            decoration: InputDecoration(
              fillColor: Colors.white.withOpacity(.8),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultPadding / 2),
                borderSide: const BorderSide(color: Colors.black54, width: 1),
              ),
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Tambol>(
                elevation: 0,
                value: controller.tambolList.obs.value[0],
                isDense: true,
                onChanged: (newValue) {
                  // controller.updatePaymentChannel(newValue!);
                },
                items: controller.tambolList.obs.value.map((item) {
                  return DropdownMenuItem<Tambol>(
                    value: item,
                    child: Text(
                      item.tName!,
                      textScaleFactor: 0.9,
                    ),
                  );
                }).toList(),
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
