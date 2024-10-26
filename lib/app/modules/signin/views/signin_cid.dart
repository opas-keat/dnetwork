import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/signin_controller.dart';

class SignInCID extends StatelessWidget {
  SignInCID({super.key});

  final SigninController controller = Get.find<SigninController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "เลขบัตรประจำตัวประชาชน",
        color: Colors.black87.withOpacity(.9),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: controller.cid,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ยืนยัน"),
          onPressed: () async {
            final resultCID = await controller.validateIDC();
            Get.back(result: resultCID);
            // if (result.obs.value) {
            //   Get.back();
            // }
          },
        ),
      ],
    );
  }
}
