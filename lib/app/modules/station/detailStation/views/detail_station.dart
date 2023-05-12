import 'package:flutter/material.dart';

import '../../../../../responsive.dart';
import '../../../../shared/constant.dart';
import 'detail_station_commiss.dart';
import 'detail_station_member.dart';
import 'detail_station_result.dart';
import 'detail_station_trainging.dart';

class DetailStation extends StatelessWidget {
  const DetailStation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Responsive.isLargeScreen(context)
              ? const DetailStationLarge()
              : const DetailStationSmall(),
        ),
        const SizedBox(width: defaultPadding / 2),
      ],
    );
  }
}

class DetailStationSmall extends StatelessWidget {
  const DetailStationSmall({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DetailStationResult(),
        SizedBox(height: defaultPadding / 2),
        DetailStationTraining(),
        SizedBox(height: defaultPadding / 2),
        DetailStationCommiss(),
        SizedBox(height: defaultPadding / 2),
        DetailStationMember(),
        SizedBox(height: defaultPadding / 2),
      ],
    );
  }
}

class DetailStationLarge extends StatelessWidget {
  const DetailStationLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DetailStationResult(),
            ),
            SizedBox(width: defaultPadding / 2),
            Expanded(
              child: DetailStationTraining(),
            ),
          ],
        ),
        SizedBox(height: defaultPadding / 2),
        Row(
          children: [
            Expanded(
              child: DetailStationCommiss(),
            ),
            SizedBox(width: defaultPadding / 2),
            Expanded(
              child: DetailStationMember(),
            ),
          ],
        ),
        SizedBox(height: defaultPadding / 2),
        // const DetailStationCommiss(),
      ],
    );
  }
}
