import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/cubits/nfc_contact/nfc_contact_cubit.dart';
import 'package:smartcard/app/utils/color_manager.dart';
import 'package:smartcard/app/widgets/PaidBeneficaryScreen.dart';
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
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('معلومات المستخدم',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,

              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem('Name',
                              '${beneficaryNfcModel.data!.firstName} ${beneficaryNfcModel.data!.lastName}'),
                          _buildInfoItem(
                              'Mobile', beneficaryNfcModel.data!.mobile ?? ''),
                          _buildInfoItem(
                              'Balance', beneficaryNfcModel.data!.balance.toString()),
                          _buildInfoItem(
                              'Card ID', beneficaryNfcModel.data!.cardID ?? ''),
                          _buildInfoItem(
                              'Address', beneficaryNfcModel.data!.address ?? ''),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                          backgroundColor: MaterialStateProperty.all(ColorManager.baseYellow),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaidBeneficaryScreen(paidBeneficaryId: beneficaryNfcModel.data!.id!),
                            ),
                          );
                        },
                        //beneficaryNfcModel.data!.id ??
                        child:
                        const Text('Pay', style: TextStyle(color: Colors.white)),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
