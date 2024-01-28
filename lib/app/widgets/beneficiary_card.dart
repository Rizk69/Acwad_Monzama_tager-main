import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/models/beneficary_model.dart';
import 'package:smartcard/app/utils/color_manager.dart';

class BeneficiaryCard extends StatelessWidget {
  final BeneficaryData data;

  const BeneficiaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: ColorManager.baseYellow,
      color: Colors.white,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          data.fullName ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Text(
              'Mobile: ${data.mobile}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'City: ${data.city}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.blue, // You can customize the color
          child: Text(
            '${data.balance}', // Display balance or any other information
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
