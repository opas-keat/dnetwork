import 'package:flutter/material.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_flat_button.dart';
import '../../../../shared/custom_text.dart';

class StationProcessWidget extends StatelessWidget {
  StationProcessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "ผลการดำเนินงาน ศส.ปชต.",
          size: 20,
          color: Colors.black87.withOpacity(.9),
        ),
        const SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(.2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultPadding / 2),
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 2),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_sharp),
              tooltip: 'เพิ่ม',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
