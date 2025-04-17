import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/chooseTheme/pages/chooseTheme.dart';
import 'package:music_app/presentation/intro/pages/intro.dart';
import 'package:music_app/presentation/profile/bloc/profile_bloc.dart';

import '../../../common/widgets/loader.dart';
import '../../../common/widgets/text_button.dart';
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
                          SizedBox(height: 20),
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightGrey,
                            ),
                            child: Image.asset(AppImages.preview),
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
                            color: Colors.redAccent,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ChooseThemeScreen(fromProfile: true),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Text(
                                "Change Theme",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Visibility(
                  visible: state.loader,
                  child: Loader()
              ),
            ],
          );
        },
      ),
    );
  }
}
