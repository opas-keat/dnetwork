import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // child: SidebarMenu(),
          child: Container(color: Colors.blue,),
        ),
        Expanded(
          flex: 4,
          // child: localNavigator(),
          child: Container(color: Colors.red,),
        ),
      ],
    );
  }
}
