import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../controllers/budget_controller.dart';

class BudgetSearch extends StatelessWidget {
  BudgetSearch({
    Key? key,
  }) : super(key: key);
  final BudgetController controller = Get.find<BudgetController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ค้นหางบประมาณ'),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              // controller: dealerCode,
              decoration: InputDecoration(
                hintText: "",
                labelText: "วันที่",
                suffixIcon: IconButton(
                  color: primaryColor,
                  onPressed: () {
                    // controller.listSystemLinkDealerByCode(
                    //   dealerCode.text,
                    // );
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
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
        // TextButton(
        //   child: const Text("เพิ่ม"),
        //   onPressed: () {},
        // ),
        TextButton(
          child: const Text("ปิด"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
