import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../controllers/address_controller.dart';

class AddressView extends StatelessWidget {
  AddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "จังหวัด",
          size: 20,
          color: Colors.black87.withOpacity(.9),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white.withOpacity(.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultPadding / 2),
              borderSide: const BorderSide(color: Colors.black87, width: 2),
            ),
            // hintText: 'Enter a search term',
          ),
        ),
        const SizedBox(height: defaultPadding),
        CustomText(
          text: "อำเภอ",
          size: 20,
          color: Colors.black87.withOpacity(.9),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white.withOpacity(.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultPadding / 2),
              borderSide: const BorderSide(color: Colors.black87, width: 2),
            ),
            // hintText: 'Enter a search term',
          ),
        ),
        const SizedBox(height: defaultPadding),
        CustomText(
          text: "ตำบล",
          size: 20,
          color: Colors.black87.withOpacity(.9),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white.withOpacity(.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultPadding / 2),
              borderSide: const BorderSide(color: Colors.black87, width: 2),
            ),
            // hintText: 'Enter a search term',
          ),
        ),
        const SizedBox(height: defaultPadding),
        CustomText(
          text: "รหัสไปรษณีย์",
          size: 20,
          color: Colors.black87.withOpacity(.9),
        ),
        const SizedBox(height: defaultPadding / 2),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white.withOpacity(.2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultPadding / 2),
              borderSide: const BorderSide(color: Colors.black87, width: 2),
            ),
            // hintText: 'Enter a search term',
          ),
        ),
      ],
    );
  }
}
