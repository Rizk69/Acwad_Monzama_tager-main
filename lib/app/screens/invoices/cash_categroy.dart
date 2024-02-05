import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes_manager.dart';
import '../../widgets/backgrond_image.dart';
import '../../widgets/default_appbar.dart';

class CashCategory extends StatelessWidget {
  const CashCategory({super.key});

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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.cashDailyScreen);
                          },
                          child: cardWidget(
                              img: 'assets/images/Group.svg', title: 'Cash')),
                      InkWell(
                          onTap: () {},
                          child: cardWidget(
                              img: 'assets/images/Vector.svg', title: 'مواد')),
                    ],
                  )
                ],
              ))
        ]));
  }

  Widget cardWidget({required String img, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 51),
      decoration: BoxDecoration(
          color: const Color(0XFFEFBB4A),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 35, child: SvgPicture.asset(img)),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
