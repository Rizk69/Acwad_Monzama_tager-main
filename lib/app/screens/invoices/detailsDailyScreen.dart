import 'package:flutter/material.dart';

import '../../utils/routes_manager.dart';
import '../../widgets/backgrond_image.dart';
import '../../widgets/default_appbar.dart';

class DetailsDailyScreen extends StatelessWidget {
  const DetailsDailyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: Stack(children: [
          imageBackground(context),
          Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: defaultAppbar(title: "الملابس", context: context),
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Color(0XFFF0CF87), width: 1)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('اسم المستفيد:  ',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Text('احمد',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('قيمة المبيعات : ',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Text('300',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight)),
                                ],
                              ),
                            ],
                          ),
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
