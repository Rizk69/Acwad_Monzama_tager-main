import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/backgrond_image.dart';
import '../../widgets/default_appbar.dart';

class CashDailyScreen extends StatelessWidget {
  const CashDailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: Stack(children: [
          imageBackground(context),
          Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: defaultAppbar(title: "المبيعات", context: context),
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: Color(0XFFF0CF87), width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Suger',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                Text('150  L.E',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight)),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              'assets/images/Rectangle 3343.png',
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                      itemCount: 4,
                    ),
                  )
                ],
              ))
        ]));
  }
}
