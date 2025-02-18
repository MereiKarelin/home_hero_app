import 'package:homehero/features/core/d_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DCoordinateInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const DCoordinateInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Введите координаты объекта'),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                    border: Border.all(color: DColor.greyColor)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Введите координаты',
                            // border: OutlineInputBorder(),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/copy.svg'),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(width: 8), // Добавлен отступ
            Container(
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(right: Radius.circular(12)), border: Border.all(color: DColor.greyColor)),
              child: TextButton(
                onPressed: () {
                  // Логика для кнопки "Добавить"
                },
                child: Text('Добавить', style: TextStyle(color: DColor.blackTextColor)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
