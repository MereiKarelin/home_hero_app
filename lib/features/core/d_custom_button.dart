import 'package:datex/features/core/d_text_style.dart';
import 'package:flutter/material.dart';

class DCustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Gradient? gradient;
  final Function() onTap;
  const DCustomButton({
    super.key,
    required this.text,
    this.color,
    this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      splashColor: Colors.transparent,
      child: Container(
        height: 49,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            text,
            style: DTextStyle.primaryWhiteText,
          ),
        ),
      ),
    );
  }
}
