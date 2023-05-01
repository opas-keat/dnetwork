List<Province> listProvince = [
  Province(
    pCode: "10",
    pName: "กรุงเทพมหานคร",
  ),
];

class Province {
  String? pName, pCode;
  Province({
    this.pCode,
    this.pName,
  });
}

List<Amphure> listAmphure = [
  Amphure(
    pCode: "10",
    aCode: "111",
    aName: "บางขุนเทียน",
  ),
];

class Amphure {
  String? pCode, pName, aCode, aName;
  Amphure({
    this.pCode,
    this.aCode,
    this.aName,
  });
}

List<Tambol> listTambol = [
  Tambol(
    pCode: "10",
    aCode: "111",
    tCode: "1111",
    tName: "แสมดำ",
    zipCode: "10150",
  ),
];

class Tambol {
  String? pCode, aCode, tCode, tName, zipCode;
  Tambol({
    this.pCode,
    this.aCode,
    this.tCode,
    this.tName,
    this.zipCode,
  });
}
