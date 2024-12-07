import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';
import '../controllers/member_controller.dart';

class MemberSearch extends StatelessWidget {
  MemberSearch({
    super.key,
  });
  final MemberController controller = Get.find<MemberController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "ค้นหาสมาชิก",
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
                text: "ชื่อ ศส.ปชต.",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.memberStationName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  CustomText(
                    text: "ข้อมูลปี",
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
                      value: controller.selectedYearOfData.value,
                      isDense: true,
                      onChanged: (newValue) {
                        controller.selectedYearOfData.value = newValue!;
                      },
                      items: controller.listYearOfData.obs.value.map((item) {
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
                text: "ชื่อ",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.memberFirstName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "นามสกุล",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.memberSurName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "เลขที่บัตรประชาชน",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.memberIdCard,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(13),
                ],
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "เบอร์โทร",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.memberTelephone,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              const SizedBox(height: defaultPadding),
              AddressView(
                showAmphure: true,
                showTambol: true,
                showPostCode: false,
              ),
              const SizedBox(height: defaultPadding),
              // const CustomText(
              //   text: 'รายชื่อร้านค้า',
              // ),
              // const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.reportFirstName.value = controller.memberFirstName.text;
            controller.reportSurName.value = controller.memberSurName.text;
            controller.reportTel.value = controller.memberTelephone.text;
            // controller.reportStationName.value =
            //     controller.memberStationName.text;
            // controller.reportPosition.value =
            //     controller.selectedMemberPosition.value;
            // controller.reportCommissAffiliateName.value =
            //     controller.commissStationName.text;
            controller.reportProvince.value =
                controller.addressController.selectedProvince.value;
            controller.reportAmphure.value =
                controller.addressController.selectedAmphure.value;
            controller.reportDistrict.value =
                controller.addressController.selectedTambol.value;
            controller.offset.value = 0;
            controller.currentPage = 1;
            controller.listMemberStatistics.clear();
            controller.listMember();
            Get.back();
          },
        ),
        TextButton(
            child: const Text("ปิด"),
            onPressed: () {
              controller.memberStationName.text = '';
              controller.memberFirstName.text = '';
              controller.memberSurName.text = '';
              controller.memberIdCard.text = '';
              controller.memberTelephone.text = '';
              controller.addressController.selectedProvince.value = '';
              controller.addressController.selectedAmphure.value = '';
              controller.addressController.selectedTambol.value = '';
              Get.back();
            }),
      ],
    );
  }
}
