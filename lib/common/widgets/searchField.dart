import 'package:flutter/material.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class SearchInputField extends StatelessWidget {
  final TextInputType input;
  final String hint;
  final FormFieldValidator<String>? validator;
  final bool obscure;
  final TextEditingController controller;
  final Function(String)? onSubmit;

  const SearchInputField({required this.hint, required this.input, super.key, required this.validator,this.obscure=false, required this.controller,this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: onSubmit,
      cursorColor: AppColors.green,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: input,
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_sharp),
        hintText: hint,
        suffixIcon: GestureDetector(onTap: (){
          controller.text="";
        },child: Icon(Icons.clear)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.isDarkMode?Colors.white:Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
