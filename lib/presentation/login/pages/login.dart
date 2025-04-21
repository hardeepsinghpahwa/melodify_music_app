import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/widgets/loader.dart';
import 'package:music_app/data/models/signInReq.dart';
import 'package:music_app/domain/usecases/signInUseCase.dart';
import 'package:music_app/presentation/register/bloc/loading/loading_bloc.dart';
import 'package:music_app/presentation/register/pages/register.dart';

import '../../../common/utils.dart';
import '../../../common/widgets/back_button.dart';
import '../../../common/widgets/basic_button.dart';
import '../../../common/widgets/inputField.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../services.dart';
import '../../dashboard/pages/dashboard.dart';
import '../../home/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(left: 20, child: RoundedBackButton()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(AppImages.logo, width: 100),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Sign In",
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
                      hint: "Enter Username or Email",
                      input: TextInputType.text,
                      controller: nameController,
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return "Enter full name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Password",
                      controller: passwordController,
                      obscure: true,
                      input: TextInputType.text,
                      validator: (val) {
                        if (val!.isEmpty || val.length < 6) {
                          return "Password must be of at least length 6";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    BasicButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          var result = await sl<SignInUseCase>().call(
                            params: SignInReq(
                              nameController.text,
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
                                  builder: (context) => Dashboard(),
                                ),
                                (route) => false,
                              );
                            },
                          );
                        }
                      },
                      title: "Sign In",
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
                        Text("Not a member? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          child: Text(
                            "Register Here",
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

            BlocBuilder<LoadingBloc, LoadingState>(
              builder: (context, state) {
                if (state is LoadingProgressState) {
                  return Loader();
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
