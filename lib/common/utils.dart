import 'package:flutter/material.dart';
import 'package:music_app/common/widgets/basic_button.dart';
import 'package:music_app/common/widgets/outlined_button.dart';
import 'package:music_app/common/widgets/small_button.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class Utils {
  static showErrorSnackbar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 120,
        left: 10,
        right: 10,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showSuccessSnackbar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 120,
        left: 10,
        right: 10,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showInfoSnackbar(String title, BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.darkGrey,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 120,
        left: 10,
        right: 10,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showBottomDialog(String title, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black.withValues(alpha: 0.5),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Text(title, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: SmallButton(onPressed: () {

                        }, title: "Yes"),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: BasicOutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          title: "No",
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
