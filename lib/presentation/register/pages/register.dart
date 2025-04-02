import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/helpers/is_valid_email.dart';
import 'package:music_app/common/widgets/back_button.dart';
import 'package:music_app/common/widgets/basic_button.dart';
import 'package:music_app/common/widgets/inputField.dart';
import 'package:music_app/common/widgets/loader.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/domain/usecases/signUpUseCase.dart';
import 'package:music_app/presentation/home/pages/home.dart';
import 'package:music_app/presentation/login/pages/login.dart';
import 'package:music_app/presentation/register/bloc/loading/loading_bloc.dart';

import '../../../common/utils.dart';
import '../../../services.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(left: 20, child: RoundedBackButton()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SvgPicture.asset(AppVectors.logo, width: 100),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 30,
                            color:
                                context.isDarkMode
                                    ? Colors.white
                                    : AppColors.darkGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "If You Need Any Support",
                              style: TextStyle(
                                color:
                                    context.isDarkMode
                                        ? Colors.white
                                        : AppColors.darkGrey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Click Here",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        InputField(
                          controller: nameController,
                          hint: "Full Name",
                          input: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty || val.length < 4) {
                              return "Enter full name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        InputField(
                          controller: emailController,
                          hint: "Enter Email",
                          input: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty || !val.isValidEmail()) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        InputField(
                          controller: passwordController,
                          hint: "Password",
                          obscure: true,
                          input: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty || val.length < 6) {
                              return "Password must be of at least length 6";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        BasicButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              var result = await sl<SignUpUseCase>().call(
                                params: CreateUserRequest(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );

                              result.fold(
                                (ifLeft) {
                                  Utils.showErrorSnackbar(ifLeft, context);
                                },
                                (ifRight) {
                                  Utils.showSuccessSnackbar(ifRight, context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                        (route) => false,
                                  );
                                  },
                              );
                            }
                          },
                          title: "Create Account",
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            Expanded(child: Divider()),
                            SizedBox(width: 10),
                            Text("Or"),
                            SizedBox(width: 10),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppVectors.google),
                                SizedBox(width: 10),
                                Text(
                                  "Continue With Google",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<LoadingBloc, LoadingState>(
              builder: (context, state) {
                return (state is LoadingProgressState) ? Loader() : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
