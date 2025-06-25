import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/chooseTheme/pages/chooseTheme.dart';
import 'package:music_app/presentation/intro/pages/intro.dart';
import 'package:music_app/presentation/profile/bloc/profile_bloc.dart';

import '../../../common/widgets/loader.dart';
import '../../../common/widgets/text_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    sl<ProfileBloc>().add(GetProfileDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkBackground : AppColors.lightGrey,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          context.isDarkMode
                              ? AppColors.darkGrey
                              : Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 15),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              Spacer(),
                              Image.asset(AppImages.logo, width: 40),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightGrey,
                            ),
                            child: Icon(Icons.person, size: 50),
                          ),
                          SizedBox(height: 10),
                          Text(
                            state.entity?.email ?? "",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            state.entity?.fullName ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color:
                                  context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          BasicTextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IntroScreen(),
                                ),
                                (Route<dynamic> route) =>
                                    false, // removes all previous routes
                              );
                            },
                            title: "Logout",
                            color: Colors.red,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        settingsTile(
                          "Theme",
                          "Change the theme of you app",
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ChooseThemeScreen(fromProfile: true),
                              ),
                            );
                          },
                          Icons.format_paint_outlined,
                          context,
                        ),

                        settingsTile(
                          "Privacy Policy",
                          "Read the privacy policy of you app",
                          () {},
                          Icons.policy_outlined,
                          context,
                        ),

                        settingsTile(
                          "Version",
                          "1.0.0",
                          () {},
                          Icons.history,
                          context,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Visibility(visible: state.loader, child: Loader()),
            ],
          );
        },
      ),
    );
  }

  Widget settingsTile(
    String title,
    String desc,
    Function() onTap,
    IconData icon,
    BuildContext ctx,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(icon, color: AppColors.primary),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: ctx.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(desc, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
