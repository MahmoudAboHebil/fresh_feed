import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/utlis.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.enable = true,
    this.initialValue = '',
    this.suffixWidget,
    this.validator,
    this.prefixIcon,
  });
  final TextEditingController controller;
  final String label;
  final String initialValue;
  final bool isPassword;
  final bool enable;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    widget.controller.text = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Theme.of(context).primaryColor,
            selectionColor: Theme.of(context).primaryColor,
          ),
        ),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: context.textTheme.bodyLarge?.color,
          textAlignVertical: TextAlignVertical.center,
          scrollPhysics: AlwaysScrollableScrollPhysics(),
          readOnly: !widget.enable,
          style: TextStyle(
            fontSize: context.setSp(16),
            fontWeight: FontWeight.w500,
            color: !widget.enable
                ? context.textTheme.bodyLarge?.color?.withOpacity(.3)
                : null,
            decorationThickness: 0,
          ),
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: context.setMinSize(12)),
                      child: Icon(
                        color: widget.enable
                            ? context.textTheme.bodyLarge?.color
                                ?.withOpacity(.70)
                            : context.textTheme.bodyLarge?.color
                                ?.withOpacity(.3),
                        widget.prefixIcon,
                        size: context.setMinSize(25),
                      ),
                    )
                  : null,
              suffixIcon: widget.suffixWidget,
              errorStyle: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: context.setSp(12)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(4)),
                borderSide: BorderSide(
                  width: 1.75,
                  color: context.colorScheme.error,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(4)),
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
              label: Text(
                widget.label,
                style: TextStyle(
                    color: widget.enable
                        ? context.textTheme.bodyLarge?.color?.withOpacity(.70)
                        : context.textTheme.bodyLarge?.color?.withOpacity(.3),
                    fontSize: context.setSp(15)),
              ),
              fillColor: Colors.transparent,
              errorMaxLines: 2,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(4)),
                borderSide: BorderSide(
                    color: context.textTheme.bodyLarge!.color!.withOpacity(0.3),
                    width: 1.3),
              ),
              isDense: true,
              contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: context.setMinSize(16),
                  vertical: context.setMinSize(13)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(4)),
                borderSide: BorderSide(
                  color: context.textTheme.bodyLarge!.color!.withOpacity(0.70),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(4)),
                borderSide: BorderSide(
                    color: context.textTheme.bodyLarge!.color!, width: 1.3),
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
