import 'package:flutter/material.dart';

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
          child: Column(
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
          ),
        ),
        const SizedBox(width: defaultPadding / 2),
      ],
    );
  }
}
