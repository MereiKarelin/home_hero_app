import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:flutter/material.dart';

class DActionButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Gradient? gradient;
  final Function() onTap;
  final Widget icon;
  final double? width;
  const DActionButton({
    super.key,
    required this.text,
    this.color,
    this.gradient,
    required this.onTap,
    required this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      splashColor: Colors.transparent,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 46,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: DColor.whiteColor,
            // gradient: gradient,
            border: Border.all(color: color ?? DColor.whiteColor, width: 2.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: DTextStyle.boldBlackText.copyWith(fontWeight: FontWeight.w500),
                ),
                icon,
              ],
            ),
          )),
    );
  }
}
