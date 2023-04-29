import 'package:flutter/material.dart';

import '../../main.dart';
import '../data/models/module.dart';
import 'constant.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // shadowColor: Colors.white,
      // backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Image.network('assets/icons/logo-300x300.png'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listModule.length,
              itemBuilder: (context, index) {
                return Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    hoverColor: primaryColor.withOpacity(0.2),
                    leading: Icon(
                      listModule[index].icon,
                    ),
                    title: Text(listModule[index].nameTH,
                        style: TextStyle(fontSize: 14)),
                    onTap: () {
                      talker.debug("edit: ${listModule[index].nameEn}");
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
