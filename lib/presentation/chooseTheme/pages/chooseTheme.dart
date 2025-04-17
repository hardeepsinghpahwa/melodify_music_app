import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/presentation/chooseTheme/widgets/mode.dart';
import 'package:music_app/presentation/loginPreview/pages/loginPreview.dart';

import '../../../common/widgets/basic_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';

class ChooseThemeScreen extends StatefulWidget {

  final bool fromProfile;

  const ChooseThemeScreen({this.fromProfile=false,super.key});

  @override
  State<ChooseThemeScreen> createState() => _ChooseThemeScreenState();
}

class _ChooseThemeScreenState extends State<ChooseThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              AppImages.chooseTheme,
            ),
            Container(color: Colors.black.withValues(alpha: 0.5)),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: SvgPicture.asset(AppVectors.logo, width: 150),
                    ),
                    Spacer(),
                    Text(
                      "Choose Mode",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Mode(
                          light: true,
                        ),
                        Mode(
                          light: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    BasicButton(
                      onPressed: () {
                        if(widget.fromProfile){
                          Navigator.pop(context);
                        }else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPreview(),
                            ),
                          );
                        }
                      },
                      title: "Continue",
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
