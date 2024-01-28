import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/utils/color_manager.dart';
import 'package:smartcard/main.dart';

import '../models/benficary_data_model.dart';

class PaidBeneficaryScreen extends StatelessWidget {
  PaidBeneficaryModel paidBeneficaryModel;

  PaidBeneficaryScreen({super.key, required this.paidBeneficaryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/img_constraction.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorManager.baseYellow,

          title: const Text('الدفعات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.8,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(11),
                margin: EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'fullName: ${paidBeneficaryModel.beneficary!.fullName ?? ''}'),
                    Text(
                        'mobile: ${paidBeneficaryModel.beneficary!.mobile ?? ''}'),
                    Text(
                        'balance: ${paidBeneficaryModel.beneficary!.balance ?? ''}'),
                    Text('city: ${paidBeneficaryModel.beneficary!.city ?? ''}'),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.7,
                child: ListView.builder(
                  itemCount: paidBeneficaryModel.paidBeneficary!.date?.length ??
                      0, // تحديد عدد العناصر
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ColorManager.baseYellow,
                          width: 1,
                        ),
                        color: paidBeneficaryModel.paidBeneficary!.date![index].paidDone==0?Colors.white:Colors.greenAccent,
                      ),
                      padding: const EdgeInsets.all(11),
                      margin:  EdgeInsets.all(11),
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          paidBeneficaryModel.paidBeneficary!.date![index].paidDone==1?Positioned.fill( // Ensuring the CustomPaint covers the whole area
                            child: CustomPaint(
                              painter: DiagonalLinePainter(),
                            ),
                          ):Container(),
                          InkWell(
                            onTap: (){
                              //appStore.userId
                              // paidBeneficaryModel.paidBeneficary!.date![index].id
                              //  paidBeneficaryModel.beneficary!.id;
                              print("Vendor Id : ${appStore.userId}" );
                              print("Beneficary Id : ${paidBeneficaryModel.beneficary!.id}" );
                              print("Paid Beneficary Id : ${paidBeneficaryModel.paidBeneficary!.date![index].id}" );

                              print(paidBeneficaryModel.paidBeneficary!.date![index].cashOrCategory);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    'نوع الصرف: ${paidBeneficaryModel.paidBeneficary!.date![index].type==0?"نقدا":"مواد عينية" ?? ''}'),
                                Text(
                                    'المبلغ المتاح: ${paidBeneficaryModel.paidBeneficary!.date![index].paidMoney ?? ''}'),
                                Text(
                                    'حاله الصرف: ${paidBeneficaryModel.paidBeneficary!.date![index].paidDone==0?"جاري":"تم الصرف" ?? ''}'),
                                Text(
                                    'التاريخ: ${paidBeneficaryModel.paidBeneficary!.date![index].date ?? ''}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                    backgroundColor: MaterialStateProperty.all(ColorManager.secondary),
                  ),
                  onPressed: () {
                    // _onPayButtonPressed(context, 5);
                  },
                  child: const Text('Continue',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Set the color of the diagonal line
      ..strokeWidth = 1; // Set the width of the diagonal line

    // Draw the line from top right to bottom left
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
