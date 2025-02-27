import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../generated/l10n.dart';
import '../providers/language_provider.dart';

class PhoneTextField extends ConsumerStatefulWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    required this.initialPhoneNumber,
    required this.callBack,
  });
  final TextEditingController controller;
  final PhoneNumber? initialPhoneNumber;
  final Function(PhoneNumber) callBack;

  @override
  ConsumerState<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends ConsumerState<PhoneTextField> {
  late PhoneNumber number;

  @override
  void initState() {
    super.initState();
    if (widget.initialPhoneNumber?.phoneNumber != null) {
      number = widget.initialPhoneNumber!;
    } else {
      number = PhoneNumber(
        isoCode: 'EG',
      );
    }
    print('sssssssssssssss');
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    final languageState = ref.watch(languageProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: Theme.of(context).primaryColor,
              selectionColor: Theme.of(context).primaryColor,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  onSurface: context.textTheme.bodyLarge?.color,
                ),
          ),
          child: InternationalPhoneNumberInput(
            onInputValidated: (bool value) {},
            cursorColor: context.textTheme.bodyLarge?.color,
            textAlignVertical: TextAlignVertical.center,
            textAlign: context.isRTL ? TextAlign.end : TextAlign.start,
            textStyle: TextStyle(
              fontSize: context.setSp(16),
              fontWeight: FontWeight.w500,
              decorationThickness: 0,
            ),
            inputDecoration: InputDecoration(
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
              hintText: S.of(context).PhoneNumber,
              hintStyle: TextStyle(
                color: context.textTheme.bodyLarge?.color?.withOpacity(.70),
                fontSize: context.setSp(15),
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
              ),
            ),
            onInputChanged: (PhoneNumber number) async {
              widget.callBack(number);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              useBottomSheetSafeArea: true,
              useEmoji: true,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: context.setMinSize(16),
              trailingSpace: false,
            ),
            locale: languageState.value?.name,
            searchBoxDecoration: InputDecoration(
              errorStyle: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: context.setSp(12)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.setMinSize(4)),
                borderSide: BorderSide(
                  width: 1.75,
                  color: context.colorScheme.error,
                ),
              ),
              hintText: S.of(context).SearchCountry,
              hintStyle: TextStyle(
                  color: context.textTheme.bodyLarge?.color?.withOpacity(.70),
                  fontSize: context.setSp(15)),
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
              ),
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: TextStyle(
                color: context.textTheme.bodyLarge?.color?.withOpacity(.80),
                fontWeight: FontWeight.w600,
                fontSize: context.setSp(15)),
            initialValue: number,
            textFieldController: widget.controller,
            formatInput: true,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            onSubmit: () {},
            onFieldSubmitted: (value) {},
          ),
        ),
      ],
    );
  }
}
