import 'package:flutter/material.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class SearchInputField extends StatelessWidget {
  final TextInputType input;
  final String hint;
  final FormFieldValidator<String>? validator;
  final bool obscure;
  final TextEditingController controller;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;

  const SearchInputField({
    required this.hint,
    required this.input,
    super.key,
    required this.validator,
    this.obscure = false,
    required this.controller,
    this.onSubmit,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff96969A).withValues(alpha: 0.15),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(12, 12),
          ),
        ],
      ),
      child: TextFormField(
        focusNode: focusNode,
        validator: validator,
        onFieldSubmitted: onSubmit,
        cursorColor: AppColors.primary,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: input,
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          fontSize: 14
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.search_sharp,size: 20,),
          hintText: hint,
          suffixIcon: GestureDetector(
            onTap: () {
              controller.text = "";
            },
            child: Icon(Icons.clear, size: 20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
