import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? initialValue;
  final String? labelText;
  final void Function(String?)? onSaved;
  final bool? enabled;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final bool? enableSuggestions;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final double? textfieldBorder;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    this.initialValue,
    required this.labelText,
    this.onSaved,
    this.enabled,
    this.validator,
    this.obscureText,
    this.enableSuggestions,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.textfieldBorder = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onSaved: onSaved,
      enabled: enabled,
      validator: validator,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enableSuggestions: enableSuggestions!,
      style: normalFont(
        enabled! ? MColors.textDark : MColors.textGrey,
        16.0,
      ),
      cursorColor: MColors.teal,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                ),
                child: suffix,
              )
            : null,
        labelText: labelText,
        labelStyle: normalFont(null, 14.0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
        fillColor: MColors.primaryWhite,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color:
                textfieldBorder == 0.0 ? Colors.transparent : MColors.textGrey,
            width: textfieldBorder!,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: MColors.teal,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
