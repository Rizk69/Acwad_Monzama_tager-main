import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../models/BeneficaryNfcModel.dart';
import 'BeneficaryNfcScreen.dart';
import '../../widgets/backgrond_image.dart';
import 'nfc_contact_cubit/nfc_contact_cubit.dart';

class NfcContactCardScreen extends StatefulWidget {
  const NfcContactCardScreen({Key? key}) : super(key: key);

  @override
  _NfcContactCardScreenState createState() => _NfcContactCardScreenState();
}

class _NfcContactCardScreenState extends State<NfcContactCardScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  bool isNfcAvailable = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _tagRead();

    checkNfcAvailability();
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  Future<void> checkNfcAvailability() async {
    try {
      isNfcAvailable = await NfcManager.instance.isAvailable();
      if (isNfcAvailable) {
        _tagRead();
      }
      setState(() {
        _tagRead();
      });
    } catch (e) {
      setState(() {
        isNfcAvailable = false;
      });
      print('Error checking NFC availability: $e');
    }
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        result.value = tag.data;
        Uint8List identifier = tag.data['nfca']['identifier'];
        var idHexString = identifier
            .map((b) => b.toRadixString(16).padLeft(2, '0'))
            .join('')
            .toUpperCase();
        bool availability = await _checkServerNfcAvailability(idHexString);
        if (availability) {
          _showPasswordDialog(idHexString);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error making server request: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error making server request: $e');
      return false;
    } finally {
      checkNfcAvailability();
    }
  }

  Future<bool> _checkPasswordNfc(String cardID, String password) async {
    const serverEndpoint = 'https://monazama.acwad-it.com/api/Beneficary/nfc';
    try {
      final cubit = NfcDataCubit();
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BeneficaryNfcScreen(
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
        return showPasswordDialog(cardId);
      },
    );
  }

  Widget showPasswordDialog(String cardId) {
    String password = '';
    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        height: MediaQuery
            .of(context)
            .size
            .height / 3,
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .primaryColorDark,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'أدخل كلمة المرور',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
            SizedBox(height: 23),
            TextFormField(
              keyboardType: TextInputType.number,
              obscureText: _isObscure,
              onChanged: (value) {
                password = value;
              },
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColorLight,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(
                      color: Theme
                          .of(context)
                          .primaryColorLight,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(
                      color: Theme
                          .of(context)
                          .primaryColorLight,
                    )),
                fillColor: Theme
                    .of(context)
                    .primaryColorLight,
                labelText: 'كلمة المرور',
                labelStyle: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                ),
                hintStyle: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme
                          .of(context)
                          .primaryColorLight, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Theme
                        .of(context)
                        .primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure; // Toggle the visibility
                    });
                  },
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () async {
                    await _checkPasswordNfc(cardId, password);
                  },
                  child: Text(
                    'موافق',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColorLight,
                    ),
                  ),
                ),
                SizedBox(width: 24.0),
                TextButton(
                  onPressed: () {
                    checkNfcAvailability();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'إلغاء',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColorLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme
            .of(context)
            .primaryColorDark,
        child: Stack(
          children: [
            imageBackground(context),
            Scaffold(
              backgroundColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              body: showPasswordDialog("336F7E86"),

              // isNfcAvailable
              //     ? Center(
              //         child: SvgPicture.asset(
              //           'assets/images/nfc_icon.svg',
              //           color: Theme.of(context).primaryColor,
              //           height: 200,
              //           width: 200,
              //         ),
              //       )
              //     : Center(
              //         child: Text(
              //         'NFC is not available',
              //         style: TextStyle(
              //           color: Theme.of(context).primaryColorLight,
              //         ),
              //       )),
            ),
          ],
        ),
      ),
    );
  }
}
