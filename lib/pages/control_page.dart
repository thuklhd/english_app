

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_app/values/app_colors.dart';
import 'package:time_management_app/values/share_key.dart';

import '../values/app_assets.dart';
import '../values/app_styles.dart';
class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue=5;
  late SharedPreferences prefs;
  @override
   initState()  {
    // TODO: implement initState
    super.initState();
    initDefauteValue();
  }
  initDefauteValue()
  async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKey.counter) ?? 5;
    setState(() {
      sliderValue=value.toDouble();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Text('Your control',style: AppStyles.h3.copyWith(color: AppColor.textColor,fontSize: 36),),
        leading: InkWell(
          onTap: () async
          {
            SharedPreferences   prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKey.counter,sliderValue.toInt() );
         Navigator.pop(context);
          },
          child: Image.asset(AppAssets.LeftArrow),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text('how munch number you want',
              style: AppStyles.h4.copyWith(color: AppColor.lightGrey, fontSize: 18),),
            Text('${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(color: AppColor.primaryColor, fontSize: 150,fontWeight: FontWeight.bold)
            ),
            Slider(value: sliderValue,min: 5,max: 100,
                divisions: 95,
                onChanged: (value){
                     setState(() {
                       sliderValue=value;
                     });

            }
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.centerLeft,
              child: Text('slide to set',
                style: AppStyles.h5.copyWith(color: AppColor.textColor),),
            )


          ],
        ),
      ),
    );
  }
}
