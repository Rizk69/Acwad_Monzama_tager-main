import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../cubits/invoice/invoice_beneficary_cubit.dart';
import '../models/BeneficaryNfcModel.dart';
import 'BeneficaryNfcScreen.dart';

class NfcContactCardScreen extends StatefulWidget {
  const NfcContactCardScreen({Key? key}) : super(key: key);

  @override
  _NfcContactCardScreenState createState() => _NfcContactCardScreenState();
}

class _NfcContactCardScreenState extends State<NfcContactCardScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  bool isNfcAvailable = false;

  @override
  void initState() {
    checkNfcAvailability();
    _tagRead();
    super.initState();
  }

  Future<void> checkNfcAvailability() async {
    try {
      isNfcAvailable = await NfcManager.instance.isAvailable();

      setState(() {});
    } catch (e) {
      setState(() {
        isNfcAvailable = false;
      });
      print('Error checking NFC availability: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isNfcAvailable
            ? Center(
                child: Image.asset(
                  'assets/images/card.png',
                  height: 200,
                  width: 200,
                ),
              )
            : const Center(child: Text('NFC is not available')),
      ),
    );
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        result.value = tag.data;

        if (tag.data.containsKey('nfca')) {
          Uint8List identifier = tag.data['nfca']['identifier'];
          var idHexString = identifier
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join('')
              .toUpperCase();

          bool availability = await _checkServerNfcAvailability(idHexString);
          if (availability) {
            _showPasswordDialog(idHexString);
          }
        }
      } catch (e) {
        print('Error reading NFC tag: $e');
      } finally {
        NfcManager.instance.stopSession();
      }
    });
  }

  Future<bool> _checkServerNfcAvailability(String cardID) async {
    const serverEndpoint =
        'https://monazama.acwad-it.com/api/Beneficary/card_nfc';

    try {
      final response = await http.post(
        Uri.parse(serverEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cardID': cardID}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['exists'] == false ? 'False' : 'True'),
            backgroundColor:
                responseBody['exists'] == false ? Colors.red : Colors.green,
          ),
        );

        print('Server response: ${response.body}');
        return responseBody['exists'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server request failed'),
            backgroundColor: Colors.red,
          ),
        );
        print('Server request failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error making server request: $e');
      return false;
    }
  }

  Future<bool> _checkPasswordNfc(String cardID, String password) async {
    const serverEndpoint = 'https://monazama.acwad-it.com/api/Beneficary/nfc';

    try {
      final cubit = InvoiceBeneficaryCubit();

      final response = await http.post(
        Uri.parse(serverEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cardID': cardID, 'cardpassword': password}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        BeneficaryNfcModel beneficaryNfcModel =
            BeneficaryNfcModel.fromJson(responseBody);

        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeneficaryNfcScreen(
              beneficaryNfcModel: beneficaryNfcModel,
              cubit: cubit,
            ),
          ),
        );

        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Server request failed'),
            backgroundColor: Colors.red,
          ),
        );
        print('Server request failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error making server request: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error making server request: $e');
      return false;
    }
  }

  void _showPasswordDialog(String cardId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return showPasswordDialog(cardId);
          },
        );
      },
    );
  }

  Widget showPasswordDialog(String cardId) {
    String password = '';

    return AlertDialog(
      title: const Text('Enter Password'),
      content: TextFormField(
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await _checkPasswordNfc(cardId, password);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
