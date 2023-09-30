import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';

class DashboardSearch extends StatelessWidget {
  DashboardSearch({
    Key? key,
  }) : super(key: key);
  final DashboardController controller = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    // final addressController = Get.put(AddressController());
    // addressController.selectedProvince.value = "0|";
    // addressController.update();
    return AlertDialog(
      title: CustomText(
        text: "ค้นหาข้อมูลสถิติ",
        color: Colors.black87.withOpacity(.9),
      ),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 480,
        height: 640,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText(
                text: "ศสร.ที่",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.stationNo,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
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
              ),
              const SizedBox(height: defaultPadding),
              AddressView(
                showAmphure: false,
                showTambol: false,
                showPostCode: false,
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.reportStationNo.value = controller.stationNo.text;
            controller.reportProvince.value =
                controller.addressController.selectedProvince.value;
            controller.listProvinceSummary.clear();
            controller.listProvinceSummaryDashboard();
            Get.back();
          },
        ),
        TextButton(
            child: const Text("ปิด"),
            onPressed: () {
              controller.stationNo.text = '';
              controller.addressController.selectedProvince.value = '';
              Get.back();
            }),
      ],
    );
  }
}
