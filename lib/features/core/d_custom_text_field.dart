import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_text_style.dart';

class DCustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? mask;
  final double? height;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;

  const DCustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.mask,
      this.height,
      this.hintStyle});

  @override
  State<DCustomTextField> createState() => _DCustomTextFieldState();
}

class _DCustomTextFieldState extends State<DCustomTextField> {
  MaskTextInputFormatter? maskFormatter;

  @override
  void initState() {
    super.initState();
    if (widget.mask != null) {
      maskFormatter = MaskTextInputFormatter(
        mask: widget.mask!,
        filter: {"#": RegExp(r'[0-9]')},
      );
    }
  }

  @override
  void didUpdateWidget(covariant DCustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mask != oldWidget.mask) {
      if (widget.mask != null) {
        maskFormatter = MaskTextInputFormatter(
          mask: widget.mask!,
          filter: {"#": RegExp(r'[0-9]')},
        );
      } else {
        maskFormatter = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: DTextStyle.boldBlackText,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          validator: widget.validator,
          inputFormatters: maskFormatter != null ? [maskFormatter!] : null,
          style: DTextStyle.primaryText.copyWith(fontSize: 14),
          decoration: InputDecoration(
            fillColor: DColor.unselectedColor, // Серый цвет фона
            filled: true, // Включение заливки цветом
            hoverColor: DColor.unselectedColor,
            hintText: widget.hint,
            hintStyle: widget.hintStyle ?? DTextStyle.primaryText.copyWith(color: Colors.black), // Черный цвет текста подсказки
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: DColor.unselectedColor, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            errorStyle: const TextStyle(color: Colors.red),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20, // Устанавливаем вертикальные отступы
              horizontal: 12, // Горизонтальные отступы
            ),
          ),
        ),
      ],
    );
  }
}
