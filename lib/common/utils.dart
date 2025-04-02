import 'package:flutter/material.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class Utils{

  static showErrorSnackbar(String title,BuildContext context){
    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 120,
          left: 10,
          right: 10),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(snackBar);
  }

  static showSuccessSnackbar(String title,BuildContext context){
    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 120,
          left: 10,
          right: 10),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(snackBar);
  }

  static showInfoSnackbar(String title,BuildContext context){
    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.darkGrey,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 120,
          left: 10,
          right: 10),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(snackBar);
  }
}