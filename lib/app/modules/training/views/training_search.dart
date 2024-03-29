import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';
import '../controllers/training_controller.dart';

class TrainingSearch extends StatelessWidget {
  TrainingSearch({
    super.key,
  });
  final TrainingController controller = Get.find<TrainingController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "ค้นหาการผึกอบรม",
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
                text: "หลักสูตร",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.trainingName,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "จากวันที่",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.trainingDateForm,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "ถึงวันที่",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.trainingDateTo,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "ประเภท",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.trainingType,
                keyboardType: TextInputType.text,
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
      ),
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.offset.value = 0;
            controller.currentPage = 1;
            controller.listTrainingStatistics.clear();
            controller.listTraining();

            Get.back();
          },
        ),
        TextButton(
            child: const Text("ปิด"),
            onPressed: () {
              controller.trainingName.text = '';
              controller.trainingDateForm.text = '';
              controller.trainingDateTo.text = '';
              controller.trainingType.text = '';
              controller.addressController.selectedProvince.value = '';
              Get.back();
            }),
      ],
    );
  }
}
