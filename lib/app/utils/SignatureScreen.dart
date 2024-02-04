import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import '../models/invoice.dart';
import '../widgets/backgrond_image.dart';

class SignatureScreen extends StatefulWidget {
  Invoice cashInvoice;

  SignatureScreen({super.key, required this.cashInvoice});

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: [
          imageBackground(context),
          Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  )),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Text(
                'Signature Pad',
                style: TextStyle(
                  fontSize: 23,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(20),
                  height: 400,
                  child: Signature(
                    color: Colors.black,
                    key: _signatureKey,
                    strokeWidth: 5.0,
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context).primaryColor)),
                    onPressed: () {
                      _signatureKey.currentState!.clear();
                    },
                    child: Text('Clear',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context).primaryColor)),
                    onPressed: () async {
                      final signature =
                          await _signatureKey.currentState!.getData();
                    },
                    child: Text('Save',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
