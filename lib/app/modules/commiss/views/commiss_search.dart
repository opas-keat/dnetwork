import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';
import '../controllers/commiss_controller.dart';

class CommissSearch extends StatelessWidget {
  CommissSearch({
    super.key,
  });
  final CommissController controller = Get.find<CommissController>();
  @override
  Widget build(BuildContext context) {
    // final addressController = Get.put(AddressController());
    // addressController.selectedProvince.value = "0|";
    // addressController.update();
    controller.listCommissPositionDD();
    return AlertDialog(
      title: CustomText(
        text: "ค้นหากรรมการ",
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
              // CustomText(
              //   text: "ชื่อ ศส.ปชต.",
              //   color: Colors.black87.withOpacity(.9),
              // ),
              // const SizedBox(height: defaultPadding / 2),
              // TextFormField(
              //   controller: controller.commissStationName,
              //   keyboardType: TextInputType.text,
              // ),
              // const SizedBox(height: defaultPadding),
              CustomText(
                text: "ชื่อ",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.commissFirstName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "นามสกุล",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.commissSurName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              // CustomText(
              //   text: "วันที่แต่งตั้ง",
              //   color: Colors.black87.withOpacity(.9),
              // ),
              // const SizedBox(height: defaultPadding / 2),
              // TextFormField(
              //   controller: controller.commissDate,
              //   keyboardType: TextInputType.text,
              // ),
              // const SizedBox(height: defaultPadding),
              CustomText(
                text: "เบอร์โทร",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.commissTelephone,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "ศส.ปชต.",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.commissStationName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              AddressView(
                showAmphure: true,
                showTambol: true,
                showPostCode: false,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "ตำแหน่งใน ศส.ปชต.",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              Obx(
                () => DropdownButtonFormField<String>(
                  isDense: true,
                  isExpanded: true,
                  value: controller.selectedCommissPosition.value,
                  onChanged: (newValue) {
                    controller.selectedCommissPosition.value = newValue!;
                  },
                  items: controller.commissPositionList.obs.value.map((item) {
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
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.reportFirstName.value = controller.commissFirstName.text;
            controller.reportSurName.value = controller.commissSurName.text;
            controller.reportTel.value = controller.commissTelephone.text;
            controller.reportPosition.value =
                controller.selectedCommissPosition.value;
            controller.reportCommissAffiliateName.value =
                controller.commissStationName.text;
            controller.reportProvince.value =
                controller.addressController.selectedProvince.value;
            controller.reportAmphure.value =
                controller.addressController.selectedAmphure.value;
            controller.reportDistrict.value =
                controller.addressController.selectedTambol.value;
            controller.offset.value = 0;
            controller.currentPage = 1;
            if (controller.selectedCommissPosition.value.isEmpty) {
              controller.defaultCommissOrder = commissOrder;
            }
            controller.listCommissStatistics.clear();
            controller.listCommiss();
            // controller.commissFirstName.text = '';
            // controller.commissSurName.text = '';
            // controller.commissTelephone.text = '';
            // controller.selectedCommissPosition.value = '';
            // controller.commissAffiliateName.text = '';
            // controller.addressController.selectedProvince.value = '';
            // controller.addressController.selectedAmphure.value = '';
            // controller.addressController.selectedTambol.value = '';
            Get.back();
          },
        ),
        TextButton(
            child: const Text("ปิด"),
            onPressed: () {
              controller.commissFirstName.text = '';
              controller.commissSurName.text = '';
              controller.commissTelephone.text = '';
              controller.selectedCommissPosition.value = '';
              controller.commissStationName.text = '';
              controller.addressController.selectedProvince.value = '';
              controller.addressController.selectedAmphure.value = '';
              controller.addressController.selectedTambol.value = '';
              Get.back();
            }),
      ],
    );
  }
}
