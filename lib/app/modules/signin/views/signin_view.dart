import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../controllers/signin_controller.dart';

class SigninView extends StatelessWidget {
  SigninView({Key? key}) : super(key: key);
  SigninController controller = Get.put(SigninController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SigninView'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: CustomFlatButton(
            label: 'Sign In'.toUpperCase(),
            onPressed: () {
              final result = controller.signIn(
                userName: 'a',
                password: 'b',
              );
            },
          ),
        ),
      ),
    );
  }
}
