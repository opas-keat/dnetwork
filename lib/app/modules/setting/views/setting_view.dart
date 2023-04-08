import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  SettingView({Key? key}) : super(key: key);
  // final ScrollController _scrollController = ScrollController();
  final List<Item> _data = generateItems(8);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: primaryColor,
                    // controller: _textEmail,
                    decoration: const InputDecoration(
                      hintText: 'ค้นหา',
                      prefixIcon: Icon(Icons.search_sharp),
                    ),
                    // validator: (value) => validateNotEmpty(value!, 'Your Email'),
                  ),
                ),
                const SizedBox(width: defaultPadding),
                CustomFlatButton(
                  color: primaryColor,
                  overlayColor: primaryLightColor,
                  padding: const EdgeInsets.all(defaultPadding),
                  isWrapped: true,
                  label: 'ค้นหา',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              // setState(() {
              _data[index].isExpanded = !isExpanded;
              // });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: ListTile(
                    title: Text(item.expandedValue),
                    subtitle: const Text(
                        'To delete this panel, tap the trash can icon'),
                    trailing: const Icon(Icons.delete),
                    onTap: () {
                      // setState(() {
                      //   _data.removeWhere((Item currentItem) => item == currentItem);
                      // });
                    }),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'จังหวัด $index',
      expandedValue: 'This is item number $index',
    );
  });
}
