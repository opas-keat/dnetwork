import 'package:flutter/material.dart';
import 'package:frontend/app/modules/dashboard/views/summary_lectuter.dart';
import 'package:frontend/app/modules/dashboard/views/summary_village.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../controllers/dashboard_controller.dart';
import 'dashboard_header.dart';
import 'summary_commiss.dart';
import 'summary_info_card.dart';
import 'summary_station.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
          const DashboardHeader(header: "จำนวนรวม"),
          const SizedBox(
            height: defaultPadding,
          ),
          const Responsive(
            smallScreen: SummaryInfoCard(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
            ),
            // tablet: FileInfoCardGridView(),
            largeScreen: SummaryInfoCard(
              childAspectRatio: 2.2,
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          SummaryStation(),
          const SizedBox(
            height: defaultPadding,
          ),
          SummaryCommiss(),
          const SizedBox(
            height: defaultPadding,
          ),
          SummaryLectuter(),
          const SizedBox(
            height: defaultPadding,
          ),
          SummaryVillage(),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}
