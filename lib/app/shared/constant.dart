import 'package:flutter/material.dart';

const backendUrl = "https://qtntktogobtletqbvjqy.nhost.run";

const primaryColor = Color(0xFF185B9D);
const primaryLightColor = Color.fromARGB(255, 55, 99, 221);
const accentColor = Color(0xFF43CEA2);
const accentLightColor = Color.fromARGB(255, 58, 68, 110);
const scaffoldBackgroundColor = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);

const double defaultPadding = 16.0;

const logActionLogin = "เข้าสู่ระบบ";

final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
final accentDivider = Padding(
  padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
  child: Divider(color: Colors.black.withOpacity(0.3), height: 1),
);
final accentDividerTop = Padding(
  padding: const EdgeInsets.only(top: defaultPadding / 2),
  child: Divider(color: Colors.black.withOpacity(0.3), height: 1),
);

// const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const canvasColor = Color.fromARGB(255, 247, 247, 245);

const commissOrder =
    "commiss_position = 'ประธานกรรมการ' DESC ,commiss_position = 'รองประธานกรรมการ' DESC ,commiss_position = 'กรรมการ' DESC ,commiss_position = 'กรรมการ/นายทะเบียน' DESC ,commiss_position = 'กรรมการ/เหรัญญิก' DESC ,commiss_position = 'กรรมการ/ประชาสัมพันธ์' DESC ,commiss_position = 'กรรมการ/เลขานุการ' DESC ";

const PRIVATE_KEY = '32characterslongpassphraseneeded';
