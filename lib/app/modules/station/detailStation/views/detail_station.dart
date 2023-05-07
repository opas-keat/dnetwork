import 'package:flutter/material.dart';

import '../../../../../responsive.dart';
import '../../../../shared/constant.dart';
import 'detail_station_commiss.dart';
import 'detail_station_member.dart';
import 'detail_station_result.dart';
import 'detail_station_trainging.dart';

class DetailStation extends StatelessWidget {
  DetailStation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Responsive.isLargeScreen(context)
              ? DetailStationLarge()
              : DetailStationSmall(),
        ),
        const SizedBox(width: defaultPadding / 2),
      ],
    );
  }
}

class DetailStationSmall extends StatelessWidget {
  DetailStationSmall({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailStationResult(),
        const SizedBox(height: defaultPadding / 2),
        DetailStationTraining(),
        const SizedBox(height: defaultPadding / 2),
        DetailStationCommiss(),
        const SizedBox(height: defaultPadding / 2),
        DetailStationMember(),
        const SizedBox(height: defaultPadding / 2),
      ],
    );
  }
}

class DetailStationLarge extends StatelessWidget {
  DetailStationLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DetailStationResult(),
            ),
            const SizedBox(width: defaultPadding / 2),
            Expanded(
              child: DetailStationTraining(),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        Row(
          children: [
            Expanded(
              child: DetailStationCommiss(),
            ),
            const SizedBox(width: defaultPadding / 2),
            Expanded(
              child: DetailStationMember(),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        // const DetailStationCommiss(),
      ],
    );
  }
}
