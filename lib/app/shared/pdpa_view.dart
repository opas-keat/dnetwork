import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/pdpa_controller.dart';

class PdpaView extends StatelessWidget {
  const PdpaView({super.key});

  @override
  Widget build(BuildContext context) {
    final PdpaController controller = Get.put(PdpaController());
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: const Column(
          children: [
            Text("เงื่อนไขการใช้งานและความเป็นส่วนตัวระบบฐานข้อมูล"),
            SizedBox(
              height: 10,
            ),
            Text(
                "ศูนย์ส่งเสริมพัฒนาประชาธิปไตย และหมู่บ้านไม่ขายเสียง ระดับประเทศ"),
            SizedBox(
              height: 10,
            ),
            Text("ของสำนักงานคณะกรรมการการเลือกตั้ง"),
            SizedBox(
              height: 10,
            ),
            Text(
                "-----------------------------------------------------------------------"),
          ],
        ),
      ),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 480,
        height: 640,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              headerText("1. วัตถุประสงค์ (Purpose Of Use And Storage)"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "สำนักงานคณะกรรมการการเลือกตั้งได้จัดให้มีการจัดเก็บรวบรวมข้อมูลส่วนบุคคล กรรมการศูนย์พัฒนาส่งเสริมประชาธิปไตยหมู่บ้านพลเมืองดีวิถีประชาธิปไตย (หมู่บ้านไม่ขายเสียง) และข้อมูลวิทยากรประชาธิปไตยไว้ก่อนวันที่พระราชบัญญัติคุ้มครองส่วนบุคคล พ.ศ. ๒๕๖๒ จะมีผลบังคับใช้ โดยมีวัตถุประสงค์เพื่อส่งเสริม สนับสนุน ให้หน่วยงานของรัฐ สถาบันการศึกษา และองค์กรเอกชน ในการสร้างความรู้ความเข้าใจที่ถูกต้องให้แก่ประชาชนเกี่ยวกับการปกครองระบอบประชาธิปไตยอันมีพระมหากษัตริย์ทรงเป็นประมุข การมีส่วนร่วมทางการเมืองของประชาชน หรือให้ประชาชนมีส่วนร่วมในการตรวจสอบการเลือกตั้ง และความรู้ที่ถูกต้องเกี่ยวกับรัฐธรรมนูญ และเพื่อให้การเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลนี้ หรือสามารถสืบค้น และสะดวกต่อการใช้งาน จึงได้นำเข้าสู่ระบบฐานข้อมูลศูนย์ส่งเสริมพัฒนาประชาธิปไตย และหมู่บ้านไม่ขายเสียงระดับประเทศ"),
              ),
              const SizedBox(height: 10),
              headerText(
                  "2. เงื่อนไขในการใช้ข้อมูล (Condition To Object Data)"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "เพื่อให้มีการรักษาความปลอดภัย หรือป้องการการสูญหาย เข้าถึง เก็บรวบรวม บันทึก ใช้ เปลี่ยนแปลง แก้ไข หรือเปิดเผยข้อมูลส่วนบุคคล โดยปราศจากอำนาจ หรือโดยมิชอบ เมื่อ พ.ร.บ.คุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562 มีผลบังคับใช้ จึงกำหนดเงื่อนไขให้ผู้ใช้งานเข้าถึงระบบฐานข้อมูล ดังนี้"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: subHeaderText(
                    "2.1 เลขา ศส.ปชต. หรือ กก.ศส.ปชต.  ที่ได้รับมอบหมาย เพื่อจัดเก็บรวบรวม บันทึก ใช้ เปลี่ยนแปลง แก้ไข หรือเปิดเผยข้อมูลส่วนบุคคล เฉพาะข้อมูล ศส.ปชต. ของตนเอง"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: subHeaderText(
                    "2.2 สนง.กกต. และ กทม.  หรือตัวแทน เพื่อจัดเก็บรวบรวม บันทึก ใช้ เปลี่ยนแปลง หรือเปิดเผยข้อมูลส่วนบุคคล เฉพาะพื้นที่จังหวัดที่รับผิดชอบในการปฏิบัติงานตามหน้าที่"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: subHeaderText(
                    "2.3 ศสร.ที่ 1 - 8 เพื่อจัดเก็บรวบรวม บันทึก ใช้ เปลี่ยนแปลง แก้ไข หรือเปิดเผยข้อมูลส่วนบุคคลข้อมูล เฉพาะพื้นที่จังหวัดที่รับผิดชอบในการปฏิบัติงานตามหน้าที่"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: subHeaderText(
                    "2.4 สนง.กกต. โดย สพค. ทำหน้าที่เป็นผู้ประมวลผลข้อมูลส่วนบุคคล เพื่อจัดเก็บรวบรวม บันทึก ใช้ เปลี่ยนแปลง แก้ไข หรือเปิดเผยข้อมูลส่วนบุคคลทุกพื้นที่จังหวัดที่เกี่ยวข้องกับการปฏิบัติงานตามหน้าที่"),
              ),
              const SizedBox(height: 10),
              headerText(
                  "3. หน้าที่และความรับผิดชอบของ กก.ศส.ปชต. (Duties And Responsibilities)"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "3.1 กก.ศส.ปชต.  หรือ วิทยากร ปชต. ต้องใช้งานข้อมูลจากระบบตามเงื่อนไขวัตถุประสงค์ตามข้อ 1 และข้อ 2 เท่านั้น"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "3.2 เลขา กก.ศส.ปชต. เป็นผู้รวบรวม บันทึก ใช้ เปลี่ยนแปลง แก้ไข หรือประสานงานเปิดเผยข้อมูลส่วนบุคคล รักษาความลับของข้อมูลส่วนบุคคลที่ตนล่วงรู้หรือได้มาเนื่องจากการปฏิบัติหน้าที่"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "3.3 เลขา ศส.ปชต.หรือ กก.ศส.ปชต. ที่ได้รับมอบหมาย ต้องแจ้ง หรือรายงาน การเก็บข้อมูลส่วนบุคคลในระบบนี้ ให้ สนง.กกต.ทราบ และแจ้งสิทธิของเจ้าของข้อมูลส่วนบุคคล"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "3.4 หาก กก.ศส.ปชต. หรือผู้ใด นำข้อมูลส่วนบุคคลไปใช้งานโดยไม่ถูกต้องตามวัตถุประสงค์ รวมถึงกรณีที่มีการนำข้อมูลไปใช้ หรือเปิดเผย ไม่เป็นไปตามข้อกำหนดการใช้งาน หรือตามที่กฎหมายกำหนด หรือทำให้มีความเสี่ยงที่จะกระทำผิดกฎหมาย จะมีโทษตาม พระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562"),
              ),
              const SizedBox(height: 10),
              headerText("4. ระยะเวลาการเก็บ (Storage Period)"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "ข้อมูล กก.ศส.ปชต. และข้อมูลส่วนบุคคลของ วิทยากร ปชต. สามารถเก็บข้อมูลไว้ได้ไม่เกิน 1 ปีนับแต่วันพ้นตำแหน่ง หรือไม่เกิน 1 ปี นับแต่บอกเลิกความยินยอม"),
              ),
              const SizedBox(height: 10),
              headerText(
                  "5. สิทธิของเจ้าของข้อมูลส่วนบุคคล (Data Subject Right)"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "กก.ศส.ปชต. หรือ วิทยากร ปชต. เจ้าของข้อมูลส่วนบุคคล มีสิทธิขอให้ สนง.กกต. ดำเนินการ ลบ หรือทำลาย หรือทำให้ข้อมูลส่วนบุคคลเป็นข้อมูลที่ไม่สามารถระบุตัวบุคคลที่เป็นเจ้าของข้อมูลส่วนบุคคลได้ เมื่อข้อมูลหมดความจำเป็นในการเก็บรักษาไว้ตามวัตถุประสงค์ในการใช้ข้อมูล"),
              ),
              const SizedBox(height: 10),
              headerText(
                  "6. นโยบายการคุ้มครองข้อมูลส่วนบุคคล (Protection Policy Data Subject)"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "เมื่อ สนง.กกต. ได้ประกาศนโยบายคุ้มครองข้อมูลส่วนบุคคลแล้ว ผู้ใช้งานทุกคนต้องให้ความสำคัญและรับผิดชอบในการคุ้มครองข้อมูลส่วนบุคคล ทั้งนี้ ในกรณีที่เจ้าของข้อมูลส่วนบุคคลมีข้อสงสัย หรือต้องการใช้สิทธิของเจ้าของข้อมูลส่วนบุคคลเกี่ยวกับนโยบายคุ้มครองข้อมูลส่วนบุคคล สามารถติดต่อได้ตามช่องทางต่อไปนี้"),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: subHeaderText(
                    "ชื่อ    :    สำนักพัฒนาเครือข่ายการเลือกตั้ง"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 72.0),
                child: subHeaderText("สำนักงานคณะกรรมการการเลือกตั้ง"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 72.0),
                child: subHeaderText(
                    "ศูนย์ราชการเฉลิมพระเกียรติฯ อาคารรัฐประศาสนภักดี (อาคารบี)"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 72.0),
                child: subHeaderText(
                    "120 ถนน แจ้งวัฒนะ แขวง ทุ่งสองห้อง เขต หลักสี่ กรุงเทพมหานคร 10210"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 72.0),
                child: subHeaderText(
                    "โทร. 0 2141 8537-39 , 52     โทรสาร 0 2143 8594 ,96"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            child: const Text("ตกลง"),
            onPressed: () async {
              final result = await controller.updatePdpa();
              if (result) {
                Get.back();
              }
            }),
      ],
    );
  }

  Widget headerText(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700, // bold
          fontSize: 18,
          // fontStyle: FontStyle.italic, // italic
        ),
      ),
    );
  }

  Widget subHeaderText(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w300, // ligth
          fontSize: 16,
          // fontStyle: FontStyle.italic, // italic
        ),
      ),
    );
  }
}
