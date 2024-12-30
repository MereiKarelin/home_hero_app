import 'package:datex/data/models/event_model.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // для форматирования даты

class DInfoCard extends StatelessWidget {
  final EventModel eventModel;
  final Color? borderColor;
  final Color? color;
  final Gradient? gradient;
  final Function() onTap;
  final double? width;

  const DInfoCard({
    super.key,
    required this.eventModel,
    this.color,
    this.gradient,
    required this.onTap,
    this.width,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    // Форматируем дату в формат дд.мм.гггг
    final String formattedDate = DateFormat('dd.MM.yyyy').format(eventModel.executionDate);

    return InkWell(
      onTap: () => onTap(),
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? DColor.whiteColor,
          // gradient: gradient,
          border: Border.all(color: borderColor ?? DColor.whiteColor, width: 2.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Левая часть: точки + Заголовок события, затем имя, адрес, комментарий
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: DColor.blueColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        eventModel.title,
                        style: DTextStyle.boldBlackText.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Медгат Мерей",
                    style: DTextStyle.boldBlackText.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'г. ${eventModel.address}',
                    style: DTextStyle.boldBlackText.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    eventModel.description,
                    style: DTextStyle.boldBlackText.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // Правая часть: Дата
              Text(
                formattedDate,
                style: DTextStyle.boldBlackText.copyWith(fontWeight: FontWeight.w400, color: DColor.greyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
