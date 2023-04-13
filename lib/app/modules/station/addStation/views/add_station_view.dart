import 'package:flutter/material.dart';
import 'package:frontend/app/modules/address/views/address_view.dart';
import 'package:frontend/app/modules/station/addStation/views/station_process_view.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_flat_button.dart';
import '../../../../shared/custom_text.dart';
import '../../controllers/station_controller.dart';
import '../controllers/add_station_controller.dart';

class AddStationView extends StatelessWidget {
  AddStationView({Key? key}) : super(key: key);
  AddStationController controller = Get.put(AddStationController());
  StationController stationController = Get.find<StationController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GetBuilder<AddStationController>(
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
          // return Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const SizedBox(height: defaultPadding * 2),
          //     CustomText(
          //       text: "รูปสถานที่",
          //       size: 20,
          //       color: Colors.black87.withOpacity(.9),
          //     ),
          //     const SizedBox(height: defaultPadding / 2),
          //     TextFormField(
          //       keyboardType: TextInputType.multiline,
          //       maxLines: 4,
          //       decoration: InputDecoration(
          //         fillColor: Colors.white.withOpacity(.2),
          //         filled: true,
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(defaultPadding / 2),
          //           borderSide:
          //               const BorderSide(color: Colors.black87, width: 2),
          //         ),
          //         // hintText: 'Enter a search term',
          //       ),
          //     ),
          //   ],
          // );
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
                    // TextFormField(
                    //   keyboardType: TextInputType.multiline,
                    //   maxLines: 4,
                    //   decoration: InputDecoration(
                    //     fillColor: Colors.white.withOpacity(.2),
                    //     filled: true,
                    //     border: OutlineInputBorder(
                    //       borderRadius:
                    //           BorderRadius.circular(defaultPadding / 2),
                    //       borderSide:
                    //           const BorderSide(color: Colors.black87, width: 2),
                    //     ),
                    //     // hintText: 'Enter a search term',
                    //   ),
                    // ),
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
                      text: "รายละเอียด ศส.ปชต.",
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
                      text: "ที่ตั้ง ศส.ปชต.",
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
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    StationProcessWidget(),
                    const SizedBox(height: defaultPadding),
                    Center(
                      child: CustomFlatButton(
                        color: primaryColor,
                        overlayColor: primaryLightColor,
                        padding: const EdgeInsets.all(defaultPadding),
                        isWrapped: true,
                        label: 'บันทึก',
                        onPressed: () {
                          stationController.isLoadingAddStation.value = true;
                          stationController.update();
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
