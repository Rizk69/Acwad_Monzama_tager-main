import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartcard/app/screens/beneficary/cubit/beneficary_cubit.dart';

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
  bool _isSignatureDone = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeneficaryCubit(),
      child: BlocConsumer<BeneficaryCubit, BeneficaryState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
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
                          onSign: () {
                            setState(() {
                              _isSignatureDone = true;
                            });
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Theme.of(context).primaryColor,
                            ),
                            textStyle: MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          onPressed: _isSignatureDone
                              ? () {
                                  _signatureKey.currentState!.clear();
                                  setState(() {
                                    _isSignatureDone = false;
                                  });
                                }
                              : null,
                          child: Text(
                            'Clear',
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColorDark),
                          ),
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
                              Theme.of(context).primaryColor,
                            ),
                            textStyle: MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          onPressed: _isSignatureDone
                              ? () async {
                                  try {
                                    final Uint8List signatureBytes =
                                        await _signatureToImageBytes();
                                    final image = await _signatureKey
                                        .currentState
                                        ?.getData();
                                    print("_${signatureBytes}__");
                                    if (signatureBytes.isNotEmpty &&
                                        image != null) {
                                      final File signatureFile =
                                          await _writeSignatureToFile(
                                              signatureBytes);
                                      BeneficaryCubit.get(context)
                                          .sendSignature(
                                        invoiceNumber:
                                            '${widget.cashInvoice.data!.invoiceNo}',
                                        file: signatureFile,
                                        beneficaryInvoice: widget.cashInvoice,
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Empty Signature"),
                                            content: Text(
                                                "Please provide a signature before saving."),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  } catch (e) {
                                    print("Error processing signature: $e");
                                    // Handle the error as needed
                                  }
                                }
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Empty Signature"),
                                        content: Text(
                                            "Please provide a signature before saving."),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Uint8List> _signatureToImageBytes() async {
    final image = await _signatureKey.currentState!.getData();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } else {
      throw Exception("Error converting signature to bytes: byteData is null");
    }
  }

  Future<File> _writeSignatureToFile(Uint8List signatureBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final signatureFile = File('$tempPath/signature.png');
      await signatureFile.writeAsBytes(signatureBytes);
      return signatureFile;
    } catch (e) {
      print("Error writing signature to file: $e");
      throw e;
    }
  }
}
