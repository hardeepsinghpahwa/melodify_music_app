import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/presentation/login/pages/login.dart';
import 'package:music_app/presentation/register/pages/register.dart';

import '../../../common/widgets/back_button.dart';
import '../../../common/widgets/basic_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';

class LoginPreview extends StatelessWidget {
  const LoginPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(AppImages.bottomDesign),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(AppImages.bottomSwirls),
            ),

            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppImages.topSwirls),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedBackButton(),
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Image.asset(AppImages.logo, width: 200),
                        ),
                        SizedBox(height: 50),
                        Text(
                          "Enjoy Listening To Music",
                          style: TextStyle(
                            fontSize: 20,
                            color: context.isDarkMode
                                ?Colors.white:Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",
                          style: TextStyle(color: Color(0xff797979)),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: BasicButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                title: "Register",
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
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
