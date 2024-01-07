import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/incident_controller.dart';

class IncidentAdd extends StatelessWidget {
  IncidentAdd({
    super.key,
    this.editMode = false,
  });
  final bool editMode;
  final IncidentController controller = Get.find<IncidentController>();
  final _formKeyIncidentAdd = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "แจ้งปัญหา",
        color: Colors.black87.withOpacity(.9),
      ),
      content: Form(
        key: _formKeyIncidentAdd,
        child: SizedBox(
          width: 480,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText(
                text: "ระบบ",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.incidentModule,
                keyboardType: TextInputType.text,
                readOnly: editMode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก ระบบ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "ปัญหา",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.incidentTitle,
                keyboardType: TextInputType.text,
                readOnly: editMode,
                maxLength: 255,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก ปัญหา';
                  }
                  return null;
                },
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "รายละเอียด",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.incidentDetail,
                keyboardType: TextInputType.text,
                readOnly: editMode,
                maxLength: 1000,
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก รายละเอียด';
                  }
                  return null;
                },
              ),
              const SizedBox(height: defaultPadding),
              editMode
                  ? CustomText(
                      text: "รายละเอียดการแก้ไข",
                      color: Colors.black87.withOpacity(.9),
                    )
                  : Container(),
              const SizedBox(height: defaultPadding / 2),
              editMode
                  ? TextFormField(
                      controller: controller.incidentResolvedDetail,
                      keyboardType: TextInputType.text,
                      maxLength: 1000,
                      maxLines: 3,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'กรุณากรอก รายละเอียดการแก้ไข';
                      //   }
                      //   return null;
                      // },
                    )
                  : Container(),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("บันทึก"),
          onPressed: () async {
            final isValid = _formKeyIncidentAdd.currentState!.validate();
            if (isValid) {
              if (editMode) {
                await controller.edit();
              } else {
                await controller.save();
              }
              controller.offset.value = 0;
              controller.currentPage = 1;
              controller.listIncidentStatistics.clear();
              await controller.list();
              Get.back();
            }
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
