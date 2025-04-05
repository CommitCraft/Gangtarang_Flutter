import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.alignment,
    this.width,
    this.height,
    this.boxDecoration,
    this.margin,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.Value,
    this.labelStyle,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
    this.prefix,
    this.label,
    this.prefixIcon,
    this.maxLength,
    this.endIcon,
    this.obscureText,
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final double? height;
  final BoxDecoration? boxDecoration;
  final EdgeInsets? margin;
  final EdgeInsets? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final TextInputType textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? Value;
  final TextStyle? labelStyle;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? endIcon;
  final Widget? label;
  final int? maxLength;
  final bool filled;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: inputFieldWithLabel(context),
          )
        : inputFieldWithLabel(context);
  }

  Widget inputFieldWithLabel(BuildContext context) => Container(
        margin: margin ?? EdgeInsets.only(right: 16,left: 16,bottom: 5,top: 5), // Apply margin here
        width: width ?? double.maxFinite,
        height: height,
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null) // Add label above the TextFormField
              Padding(
                padding: EdgeInsets.only(bottom: 4.h,top: 4),
                child: Text(
                  labelText!,
                  style: labelStyle ?? CustomTextStyles.labelLargeOnPrimary13,
                ),
              ),
            TextFormField(
              obscureText: obscureText ?? false,
              initialValue: Value,
              scrollPadding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: controller,
              focusNode: focusNode,
              maxLength: maxLength,
              onTapOutside: (event) {
                if (focusNode != null) {
                  focusNode!.unfocus();
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              autofocus: autofocus,
              style: textStyle ?? CustomTextStyles.bodyLargeBluegray900,
              keyboardType: textInputType,
              maxLines: maxLines ?? 1,
              decoration: decoration,
              validator: validator,
              onChanged: (String value) {
                onChanged?.call(value);
              },
            ),
          ],
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.titleSmallErrorContainer,
        contentPadding: contentPadding ?? EdgeInsets.all(10.h),
        fillColor: fillColor ?? appTheme.whiteA700,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(color: appTheme.indigo100, width: 1),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(color: appTheme.indigo100, width: 1),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1,
              ),
            ),
            prefix: prefix,
            suffixIcon: endIcon,
            prefixIcon: prefixIcon,
            label: label,
          
      );
}
