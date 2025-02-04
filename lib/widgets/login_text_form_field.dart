import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';

class LoginTextFormField extends StatefulWidget {
  const LoginTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hasError,
    this.isPassword = false,
    this.validator,
  });
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool hasError;

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: context.setWidth(55),
      height: widget.hasError ? context.setMinSize(70) : context.setMinSize(53),
      // color: Colors.red,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Theme.of(context).primaryColor,
            selectionColor: Theme.of(context).primaryColor,
          ),
        ),
        child: TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.isPassword ? _obscureText : false,
          cursorColor: context.colorScheme.onSecondary,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: context.setSp(15),
            fontWeight: FontWeight.w500,
            decorationThickness: 0,
          ),
          decoration: InputDecoration(
              suffixIcon: widget.isPassword && _focusNode.hasFocus
                  ? IconButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.only(
                            start: context.setMinSize(5),
                            end: context.setMinSize(15)),
                        minimumSize: const Size(0, 0),
                      ),
                      icon: Icon(
                        size: context.setMinSize(25),
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              errorStyle: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: context.setSp(12)),
              isDense: false,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(8)),
                borderSide: BorderSide(
                  width: 1.75,
                  color: context.colorScheme.error,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(8)),
                borderSide: BorderSide(
                  color: context.colorScheme.error,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(8)),
                borderSide: BorderSide(
                  color: context.colorScheme.error,
                ),
              ),
              filled: true,
              fillColor: context.colorScheme.secondary,
              hintText: widget.label,
              hintStyle: TextStyle(
                color: context.colorScheme.tertiary.withOpacity(0.9),
                fontSize: context.setSp(16),
                fontWeight: FontWeight.normal,
              ),
              contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: context.setMinSize(15),
                  vertical: context.setMinSize(7)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(8)),
                borderSide: BorderSide(
                  color: context.colorScheme.onSecondary.withOpacity(0.90),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(8)),
                borderSide: BorderSide(
                  color: context.colorScheme.primary,
                ),
              )),
          validator: widget.validator,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
