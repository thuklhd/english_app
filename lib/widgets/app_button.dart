import 'package:flutter/material.dart';
import 'package:time_management_app/values/app_colors.dart';
import 'package:time_management_app/values/app_styles.dart';
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback ontap;
  const AppButton ({Key? key,required this.label,required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
        ontap();
      }
      ,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
            horizontal: 16
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14

        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(3,6),
              blurRadius: 6
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(label,
          style: AppStyles.h3.copyWith(color: AppColor.textColor),

        ),
      ),
    );
  }
}
