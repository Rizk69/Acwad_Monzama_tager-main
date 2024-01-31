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
        color: Theme.of(context).canvasColor,
        child: Stack(
          children: [
            imageBackground(context),
            Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                title: Text(
                  'معلومات المستخدم',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    )),
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
                        _buildInfoItem(
                            'الاسم',
                            '${beneficaryNfcModel.data!.firstName} ${beneficaryNfcModel.data!.lastName}',
                            context),
                        _buildInfoItem('رقم التليفون',
                            beneficaryNfcModel.data!.mobile ?? '', context),
                        _buildInfoItem(
                            'الرصيد',
                            beneficaryNfcModel.data!.balance.toString(),
                            context),
                        _buildInfoItem('رقم الكارت',
                            beneficaryNfcModel.data!.cardID ?? '', context),
                        _buildInfoItem('العنوان',
                            beneficaryNfcModel.data!.address ?? '', context),
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

  Widget _buildInfoItem(String label, String value, BuildContext context) {
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
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
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
