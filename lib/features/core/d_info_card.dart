import 'package:auto_route/auto_route.dart';
import 'package:datex/data/models/event_model.dart';
import 'package:datex/data/models/user_info_model.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/utils/app_router.gr.dart';
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
      onTap: () {
        if (eventModel.eventType == "REGULAR") {
          AutoRouter.of(context).push(AddEventRoute(isCreate: false, eventModel: eventModel));
        } else {
          AutoRouter.of(context).push(ExtraEventRoute(
              isCreate: false, eventModel: eventModel, userInfoModel: UserInfoModel(name: '', number: '', location: '', address: '', imageId: '', id: 0)));
        }
      },
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
                    eventModel.followingUserId.toString(),
                    style: DTextStyle.boldBlackText.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    eventModel.address,
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
