import 'package:auto_route/auto_route.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/core/d_custom_text_field.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: Container(
              color: DColor.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DCustomButton(
                    text: 'Создать событие',
                    onTap: () {
                      AutoRouter.of(context).maybePop();
                    },
                    // color: DCol,
                    gradient: DColor.primaryGreenGradient,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DCustomButton(
                    text: 'Назад',
                    onTap: () {
                      AutoRouter.of(context).maybePop();
                    },
                    color: DColor.greyColor,
                    // gradient: DColor.,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
          title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Создать событие',
                style: DTextStyle.primaryText.copyWith(fontSize: 18),
              )),
          centerTitle: true,
          actions: [
            InkWell(
              child: const Icon(Icons.search, color: Colors.black),
              onTap: () {
                // Действие при нажатии на иконку поиска
              },
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/settings.svg'),
                  onPressed: () {
                    // Действие при нажатии на иконку
                  },
                ),
                Positioned(
                  right: 5,
                  top: 24,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: DColor.blueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 18,
                    width: 17,
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DCustomTextField(
                label: '',
                hint: 'Выберите Обьект*',
                hintStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
              ),
              DCustomTextField(
                label: '',
                hint: 'Дата',
                hintStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
              ),
              DCustomTextField(
                label: '',
                hint: 'Добавьте описание события*',
                hintStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
              ),
              DCustomTextField(
                label: '',
                hint: 'Выберете сервисный интервал*',
                hintStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
              ),
              DCustomTextField(
                label: '',
                hint: 'Статус',
                hintStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
              ),
              DCustomTextField(
                label: '',
                hint: 'Комментарий',
                hintStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
              ),
            ],
          ),
        ));
  }
}
