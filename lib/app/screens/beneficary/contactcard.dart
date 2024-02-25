import 'package:flutter/material.dart';
import 'package:smartcard/app/screens/beneficary/nfcccontactscreen.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({super.key});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "بطاقة المستفيد",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorManager.primary,
      ),
      body: NfcContactCardScreen(isHome: true),
    );
  }
}
