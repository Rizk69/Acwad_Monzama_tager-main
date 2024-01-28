import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/color_manager.dart';

import '../widgets/nfcccontactscreen.dart';

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
      body: const NfcContactCardScreen(),
    );
  }
}
