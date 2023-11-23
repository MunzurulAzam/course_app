
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loginapp/components.dart';
import 'package:loginapp/src/views/widgets/base_widgets/custom_text_field_widget.dart';

class CustomTextField1 extends StatefulWidget {
  final bool autofocus;
  final String hintText;
  final String svg;
  final Widget? prefixChild;
  final TextEditingController? textEditingController;
  final void Function(String value)? onChanged;
  final Future<void>? Function(String)? onChangedProcessing;
  final String? Function(String? value)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? initialValue;
  final int? maxLine;
  const CustomTextField1({
    super.key,
    this.autofocus = false,
    this.hintText = "",
    this.svg = "",
    this.textEditingController,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.onChangedProcessing,
    this.maxLine = 1,
    this.prefixChild,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  late final TextEditingController tC;
  final RxString s = "".obs;
  final RxBool errorStatus = false.obs;
  late final RxBool showText = true.obs;

  @override
  initState() {
    super.initState();
    tC = widget.textEditingController ?? TextEditingController();
    s.value = tC.text;
    showText.value = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        autofocus: widget.autofocus,
        textEditingController: tC,
        initialValue: widget.initialValue,
        hintText: widget.hintText,
        keyboardType: widget.keyboardType,
        obscureText: !showText.value,
        maxLines: widget.maxLine,
        onFocusChange: (isFocused) => {
          if (widget.obscureText && !isFocused) showText.value = false
        },
        //! Eye button
        suffixIcon: !widget.obscureText
            ? null
            : s.isEmpty
                ? null
                : GestureDetector(
                    onTap: () => showText.value = !showText.value,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: SvgPicture.asset(
                        showText.value ? "lib/assets/icons/eye_opened_icon.svg" : "lib/assets/icons/eye_closed_icon.svg",
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
        validator: widget.validator,
        errorCheck: (error) {
          s.value = "";
          errorStatus.value = error;
        },
        onChanged: (value) {
          s.value = value;
          if (widget.onChanged != null) widget.onChanged!(value.trim());
        },
        onChangedProcessing: widget.onChangedProcessing,
        showPrefixLoadingIcon: widget.onChangedProcessing != null,
        prefixIcon: widget.svg.isEmpty
            ? null
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.svg,
                      height: defaultPadding / 1.5,
                      colorFilter: ColorFilter.mode(
                        errorStatus.value
                            ? Theme.of(context).colorScheme.error
                            : s.isEmpty
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                                : Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (widget.prefixChild != null) SizedBox(width: defaultPadding / 3),
                    if (widget.prefixChild != null) widget.prefixChild!,
                  ],
                ),
              ),
      ),
    );
  }
}
