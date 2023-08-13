import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';
import '../controllers/lectuter_controller.dart';

class LectuterSearch extends StatelessWidget {
  LectuterSearch({
    Key? key,
  }) : super(key: key);
  final LectuterController controller = Get.find<LectuterController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "ค้นหาวิทยากรประชาธิปไตย",
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
              controller: controller.lectuterFirstName,
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
            CustomText(
              text: "นามสกุล",
              color: Colors.black87.withOpacity(.9),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: controller.lectuterSurName,
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
            CustomText(
              text: "เบอร์โทร",
              color: Colors.black87.withOpacity(.9),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: controller.lectuterTelephone,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
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
            CustomText(
              text: "หน่วยงาน",
              color: Colors.black87.withOpacity(.9),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: controller.lectuterAgency,
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
            CustomText(
              text: "สังกัด",
              color: Colors.black87.withOpacity(.9),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: controller.lectuterAffiliate,
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
              showAmphure: false,
              showTambol: false,
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
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.listLectuter();
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
