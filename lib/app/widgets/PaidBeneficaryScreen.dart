import 'package:flutter/material.dart';

import '../models/benficary_data_model.dart';

class PaidBeneficaryScreen extends StatelessWidget {
  PaidBeneficaryModel paidBeneficaryModel;

  PaidBeneficaryScreen({super.key, required this.paidBeneficaryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                itemCount: paidBeneficaryModel.paidBeneficary!.date?.length ??
                    0, // تحديد عدد العناصر
                itemBuilder: (context, index) {
                  return Container(
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
                            'cashOrCategory: ${paidBeneficaryModel.paidBeneficary!.date![index].cashOrCategory ?? ''}'),
                        Text(
                            'paidMoney: ${paidBeneficaryModel.paidBeneficary!.date![index].paidMoney ?? ''}'),
                        Text(
                            'paidDone: ${paidBeneficaryModel.paidBeneficary!.date![index].paidDone ?? ''}'),
                        Text(
                            'date: ${paidBeneficaryModel.paidBeneficary!.date![index].date ?? ''}'),
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
                  backgroundColor: MaterialStateProperty.all(Colors.black),
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
    );
  }
}
