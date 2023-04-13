import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_flat_button.dart';
import '../../../../shared/custom_text.dart';
import '../../controllers/commiss_controller.dart';
import '../controllers/add_commiss_controller.dart';

class AddCommissView extends StatelessWidget {
  AddCommissView({Key? key}) : super(key: key);
  AddCommissController controller = Get.put(AddCommissController());
  CommissController commissController = Get.find<CommissController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GetBuilder<AddCommissController>(
        init: controller,
        builder: (controller) {
          // loading
          if (controller.isLoading.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
              child: Center(
                child: const CircularProgressIndicator().reactive(),
              ),
            );
          }
          return Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: defaultPadding * 2),
                    CustomText(
                      text: "รูปถ่าย",
                      size: 20,
                      color: Colors.black87.withOpacity(.9),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 640,
                            maxWidth: 480,
                          );
                          if (pickedFile != null) {
                            controller.fileUpload.value = pickedFile;
                            controller.update();
                          }
                        },
                        child: Obx(() => SizedBox(
                              height: 150,
                              child:
                                  (controller.fileUpload.value.path.isNotEmpty)
                                      ? Image.network(
                                          controller.fileUpload.value.path,
                                          height: 150,
                                          fit: BoxFit.fitHeight,
                                        )
                                      : Image.network(
                                          'assets/images/undraw_Add_files_re_v09g.png',
                                          fit: BoxFit.fitHeight,
                                        ),
                            )),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ศส.ปชต.",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "คำนำหน้า",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ชื่อ",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "นามสกุล",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "วัน เดือน ปี ที่แต่งตั้ง",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ตำแหน่งใน ศส.ปชต.",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "เลขที่บัตรประชาชน",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ที่อยู่",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ปีเกิด",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "เบอร์โทรศัพท์",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "Line",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "Facebook",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ตำแหน่งอื่นในชุมชน",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "ประสบการณ์มีส่วนร่วมในการเลือกตั้ง",
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
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black87, width: 2),
                        ),
                        // hintText: 'Enter a search term',
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Center(
                      child: CustomFlatButton(
                        color: primaryColor,
                        overlayColor: primaryLightColor,
                        padding: const EdgeInsets.all(defaultPadding),
                        isWrapped: true,
                        label: 'บันทึก',
                        onPressed: () {
                          commissController.isLoadingAdd.value = true;
                          commissController.update();
                        },
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 2),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          );
        },
      ),
    );
  }
}
