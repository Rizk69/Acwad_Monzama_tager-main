import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/cubits/nfc_contact/nfc_contact_cubit.dart';
import 'package:smartcard/app/screens/PaidBeneficaryScreen.dart';
import 'package:smartcard/app/screens/home_form.dart';
import 'package:smartcard/app/utils/color_manager.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import '../models/BeneficaryNfcModel.dart';

class BeneficaryNfcScreen extends StatelessWidget {
  final BeneficaryNfcModel beneficaryNfcModel;
  final NfcDataCubit cubit;

  const BeneficaryNfcScreen(
      {super.key, required this.beneficaryNfcModel, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NfcDataCubit(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            imageBackground(context),
            Scaffold(
               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: const Text(
                  'معلومات المستخدم',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeForm()),
                      );
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        Image.asset('assets/images/profile.png', height: 75),
                        const SizedBox(
                          height: 35,
                        ),
                        _buildInfoItem('الاسم',
                            '${beneficaryNfcModel.data!.firstName} ${beneficaryNfcModel.data!.lastName}'),
                        _buildInfoItem('رقم التليفون',
                            beneficaryNfcModel.data!.mobile ?? ''),
                        _buildInfoItem('الرصيد',
                            beneficaryNfcModel.data!.balance.toString()),
                        _buildInfoItem('رقم الكارت',
                            beneficaryNfcModel.data!.cardID ?? ''),
                        _buildInfoItem(
                            'العنوان', beneficaryNfcModel.data!.address ?? ''),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(8)),
                          backgroundColor: MaterialStateProperty.all(
                              ColorManager.baseYellow),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaidBeneficaryScreen(
                                  paidBeneficaryId:
                                      beneficaryNfcModel.data!.id!),
                            ),
                          );
                        },
                        //beneficaryNfcModel.data!.id ??
                        child: const Text('الدفع',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Color(0XFF6A6969),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
