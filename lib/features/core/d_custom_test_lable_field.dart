import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DCustomTextLableField extends StatefulWidget {
  final String label;
  final String initialText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? mask;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextStyle textStyle;

  const DCustomTextLableField({
    super.key,
    required this.label,
    required this.initialText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.mask,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    required this.textStyle,
  });

  @override
  State<DCustomTextLableField> createState() => _DCustomTextLableFieldState();
}

class _DCustomTextLableFieldState extends State<DCustomTextLableField> {
  late final TextEditingController _effectiveController;
  MaskTextInputFormatter? maskFormatter;

  @override
  void initState() {
    super.initState();

    // Если контроллер не передан - создаём свой
    if (widget.controller == null) {
      _effectiveController = TextEditingController(text: widget.initialText);
    } else {
      _effectiveController = widget.controller!;
      if (_effectiveController.text.isEmpty) {
        _effectiveController.text = widget.initialText;
      }
    }

    // Инициализация маски, если указана
    if (widget.mask != null) {
      maskFormatter = MaskTextInputFormatter(
        mask: widget.mask!,
        filter: {"#": RegExp(r'[0-9]')},
      );
    }
  }

  @override
  void didUpdateWidget(DCustomTextLableField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если маска изменилась, пересоздаём форматтер
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
    return TextFormField(
      readOnly: widget.readOnly,
      controller: _effectiveController,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      inputFormatters: maskFormatter != null ? [maskFormatter!] : null,
      // Стиль самого текста
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        // labelText заменяет нам “всегда видимый” лейбл;
        // если поле пустое и не в фокусе, текст лейбла выглядит как hint,
        // при вводе фокусе лейбл «плавает» вверх.
        labelText: widget.label,

        // Опционально можно добавить сноску, что поле обязательно
        // labelText: '${widget.label} *' // если нужно
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        // (не обязательно) Если хотите, чтобы лейбл всегда оставался сверху,
        // используйте FloatingLabelBehavior.always

        // Стиль лейбла
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
        ),

        // Стиль и отступы
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}
