import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/pdpa_view.dart';
import '../controllers/signin_controller.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key});
  final SigninController controller = Get.put(SigninController());

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // usernameController.text = "user001";
    // passwordController.text = "123456";
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(
                horizontal: Responsive.isSmallScreen(context) ? 30 : 60,
                vertical: Responsive.isSmallScreen(context) ? 30 : 60),
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultPadding))),
            child: Container(
              height: 650.0,
              decoration: const BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(defaultPadding)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    primaryColor,
                    accentColor,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(defaultPadding),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                "assets/icons/logo-300x300.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          CustomText(
                            text: "ชื่อผู้ใช้ ",
                            size: 20,
                            color: Colors.white.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
                            controller: usernameController,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            autofillHints: const <String>[
                              AutofillHints.username
                            ],
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              fillColor: Colors.white.withOpacity(.2),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          CustomText(
                            text: "รหัสผ่าน",
                            size: 20,
                            color: Colors.white.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              fillColor: Colors.white.withOpacity(.2),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          Center(
                            child: ElevatedButton.icon(
                              label: CustomText(
                                text: "เข้าสู่ระบบ",
                                size: 20,
                                color: Colors.white.withOpacity(.9),
                              ),
                              icon: const Icon(Icons.key_outlined),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                              ),
                              onPressed: () async {
                                Get.dialog(
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  barrierDismissible: false,
                                );
                                final result = await controller.signIn(
                                  userName: usernameController.text,
                                  password: passwordController.text,
                                );
                                Get.back();
                                result
                                    ? {
                                        // if (controller.isPdpaCheck.value
                                        //         .toString() ==
                                        //     "Y")
                                        //   {
                                        //     Get.dialog(
                                        //       const Center(
                                        //         child: PdpaView(),
                                        //       ),
                                        //       barrierDismissible: false,
                                        //     ),
                                        //     // Get.offAllNamed(Routes.DASHBOARD),
                                        //   }
                                        // else
                                        //   {Get.offAllNamed(Routes.DASHBOARD)}
                                        Get.offAllNamed(Routes.DASHBOARD)
                                      }
                                    : Get.snackbar(
                                        'Error',
                                        controller.authenError.value,
                                        backgroundColor: accentColor,
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.white,
                                        icon: const Icon(
                                          Icons.lock_person_outlined,
                                          color: Colors.white,
                                        ),
                                        isDismissible: true,
                                        margin: const EdgeInsets.all(
                                          defaultPadding,
                                        ),
                                      );
                              },
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Version 0.0.34",
                                color: Colors.white.withOpacity(.9),
                                scale: 0.9,
                              ),
                              IconButton(
                                onPressed: () {
                                  window.location.reload();
                                },
                                icon: const Icon(
                                  Icons.refresh_sharp,
                                  color: Colors.white,
                                ),
                                color: primaryColor,
                                iconSize: 14,
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultPadding),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                window.open(
                                    'https://docs.google.com/forms/d/e/1FAIpQLSdGplojTJM17s3GoiKT_AYvRWXyGNrnbeLwZOfx_OoFKDQtog/viewform',
                                    'แจ้งปัญหา');
                              },
                              child: CustomText(
                                text: "แจ้งปัญหา",
                                color: Colors.white.withOpacity(.9),
                                scale: 0.9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    if (!Responsive.isSmallScreen(context))
                      Expanded(
                          child: Image.network(
                        "assets/icons/logo-300x300.png",
                        fit: BoxFit.none,
                      )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
