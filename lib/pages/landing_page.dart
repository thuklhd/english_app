import 'package:flutter/material.dart';
import 'package:time_management_app/main.dart';
import 'package:time_management_app/values/app_assets.dart';
import 'package:time_management_app/values/app_colors.dart';
import 'package:time_management_app/values/app_styles.dart';

import 'home_page.dart';
class landingPage extends StatelessWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(child: Container(
              alignment: Alignment.centerLeft,
              child:  Text("Welcome to",
              style: AppStyles.h3
              ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Text('English',
                  style: AppStyles.h2.copyWith(
                    color: AppColor.blackGray
                  ),

                ),
                Text('Qoutes',
                textAlign: TextAlign.right,
                style: AppStyles.h4.copyWith(
                  height: 0.2,
                ),
                )
              ],
            ),


            Expanded(child: RawMaterialButton(
              onPressed: (){

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomePage()), (route) => false);
              },
              shape:  CircleBorder(
              side: BorderSide(width: 1)
              ),
              fillColor: AppColor.lightBlue,
              child: Image.asset(AppAssets.rightArrow,width: 40,height: 40),
            )
            )
          ],
        ),
      ),
    );
  }
}

