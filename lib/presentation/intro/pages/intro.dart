import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/widgets/basic_button.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/presentation/chooseTheme/pages/chooseTheme.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
              AppImages.introBack,
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
                      child: Image.asset(AppImages.logo, width: 150),
                    ),
                    Spacer(),
                    Text(
                      "Enjoy Listening To Music",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
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
                    BasicButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseThemeScreen(),
                          ),
                        );
                      },
                      title: "Get Started",
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
