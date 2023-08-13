import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';
import '../controllers/station_controller.dart';

class StationSearch extends StatelessWidget {
  StationSearch({
    Key? key,
  }) : super(key: key);
  final StationController controller = Get.find<StationController>();
  @override
  Widget build(BuildContext context) {
    // final addressController = Get.put(AddressController());
    // addressController.selectedProvince.value = "0|";
    // addressController.update();
    return AlertDialog(
      title: CustomText(
        text: "ค้นหาศส.ปชต.",
        color: Colors.black87.withOpacity(.9),
      ),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomText(
              text: "ชื่อ",
              color: Colors.black87.withOpacity(.9),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: controller.name,
              keyboardType: TextInputType.text,
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
            ),
            const SizedBox(height: defaultPadding),
            AddressView(
              showAmphure: true,
              showTambol: true,
              showPostCode: false,
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.listStation();
            Get.back();
          },
        ),
        TextButton(
          child: const Text("ปิด"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}