import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/provider/language_provider.dart';
import 'package:daily_meme_digest/util/color_resources.dart';
import 'package:daily_meme_digest/util/dimensions.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:daily_meme_digest/util/styles.dart';

class CustomField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final Function onTap;
  final Function onChanged;
  final Function validator;
  final Function onSuffixTap;
  final Function onEditingComplete;
  final IconData suffixIcon;
  final String prefixIconUrl;
  final bool isSearch;
  final Function onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final LanguageProvider languageProvider;
  final int maxLength;
  final bool readOnly;
  final String initialValue;

  CustomField({
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor,
    this.onSubmit,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIconUrl,
    this.isSearch = false,
    this.languageProvider,
    this.maxLength,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      maxLines: widget.maxLines,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,
      focusNode: widget.focusNode,
      style: poppinsMedium.copyWith(
        fontSize: 12.sp,
      ),
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
            ]
          : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            bottom: 0,
            top: (widget.maxLines > 1) ? 2.h : 0,
            left: 2.h,
            right: 0),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.5,
            color: Color(0xFFB1B1B1),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.5,
            color: Color(0xFFB1B1B1),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.5,
            color: Color(0xFFB1B1B1),
          ),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor != null ? widget.fillColor : Colors.white,
        hintStyle: poppinsMedium.copyWith(
          fontSize: 12.sp,
          color: Color(0xFFB1B1B1),
        ),
        labelStyle: poppinsMedium.copyWith(
          fontSize: 12.sp,
          color: ColorResources.COLOR_BLACK,
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: Colors.red,
          ),
        ),
        errorStyle: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: Dimensions.FONT_SIZE_SMALL.sp,
              color: Colors.red,
              fontStyle: FontStyle.italic,
            ),
        counterStyle: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: Dimensions.FONT_SIZE_SMALL.sp,
              color: ColorResources.COLOR_BLACK,
            ),
        filled: true,
        prefixIcon: widget.isShowPrefixIcon
            ? Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_SMALL.h,
                  right: Dimensions.PADDING_SIZE_SMALL.h,
                ),
                child: (widget.prefixIconUrl != null)
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL.h),
                        child: Image.asset(
                          widget.prefixIconUrl,
                          width: Dimensions.FONT_SIZE_DEFAULT.sp,
                          height: Dimensions.FONT_SIZE_DEFAULT.sp,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL.h),
                        child: SizedBox(
                          width: Dimensions.FONT_SIZE_DEFAULT.sp,
                          height: Dimensions.FONT_SIZE_DEFAULT.sp,
                        ),
                      ),
              )
            : SizedBox.shrink(),
        prefixIconConstraints:
            BoxConstraints(minWidth: 2.0.h, maxHeight: 2.0.h),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: Dimensions.FONT_SIZE_LARGE.sp,
                      color: ColorResources.COLOR_BLACK.withOpacity(0.5),
                    ),
                    onPressed: _toggle,
                  )
                : widget.isIcon
                    ? Icon(
                        widget.suffixIcon,
                        size: Dimensions.FONT_SIZE_DEFAULT.sp,
                        color: ColorResources.COLOR_BLACK,
                      )
                    : null
            : Icon(
                widget.suffixIcon,
                size: Dimensions.FONT_SIZE_LARGE.sp,
                color: ColorResources.COLOR_BLACK,
              ),
      ),
      onEditingComplete:
          widget.onEditingComplete != null ? widget.onEditingComplete : () {},
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: (widget.inputType == TextInputType.emailAddress)
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Field tidak boleh kosong';
              } else if (!EmailValidator.validate(value)) {
                return 'Email anda tidak valid';
              }

              return null;
            }
          : (widget.isPassword)
              ? (value) {
                  RegExp regex =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                  print('password >> ${regex.hasMatch(value)}');
                  if (value == null || value.isEmpty) {
                    return 'field is required';
                  } else if (value.length < 6) {
                    return 'Password must be more than 6 characters';
                  }

                  return null;
                }
              : (widget.validator != null)
                  ? widget.validator
                  : (value) {
                      if (value == null || value.isEmpty) {
                        return 'field is required';
                      }

                      return null;
                    },
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
