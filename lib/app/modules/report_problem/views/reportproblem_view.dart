import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reportproblem_controller.dart';

class ReportproblemView extends StatelessWidget {
  ReportproblemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReportproblemView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReportproblemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
