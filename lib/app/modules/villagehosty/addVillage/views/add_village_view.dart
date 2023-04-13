import 'package:flutter/material.dart';
import 'package:frontend/app/modules/villagehosty/controllers/villagehosty_controller.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_flat_button.dart';
import '../../../../shared/custom_text.dart';
import '../../../address/views/address_view.dart';
import '../controllers/add_village_controller.dart';

class AddVillageView extends StatelessWidget {
  AddVillageView({Key? key}) : super(key: key);
  AddVillageController controller = Get.put(AddVillageController());
  VillagehostyController lectuterController =
      Get.find<VillagehostyController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GetBuilder<AddVillageController>(
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
                      text: "รูปสถานที่",
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
                      text: "ชื่อหมู่บ้าน",
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
                      text: "หมู่ที่",
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
                    AddressView(),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "จำนวนครัวเรือน",
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
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomText(
                      text: "กิจกรรมขับเคลื่อนระดับหมู่บ้าน",
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
                          lectuterController.isLoadingAdd.value = true;
                          lectuterController.update();
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
