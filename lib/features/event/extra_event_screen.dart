import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_custom_text_field.dart';
import 'package:homehero/features/core/d_custom_text_lable_field.dart';
import 'package:homehero/features/core/d_drop_down_button.dart';
import 'package:homehero/features/core/d_image_picker_widget.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/event/bloc/event_bloc.dart';
import 'package:homehero/features/following/following_screen.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
// import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ExtraEventScreen extends StatefulWidget {
  final bool isCreate;
  final EventModel? eventModel;
  final UserInfoModel userInfoModel;
  const ExtraEventScreen({super.key, required this.isCreate, this.eventModel, required this.userInfoModel});

  @override
  State<ExtraEventScreen> createState() => _ExtraEventScreenState();
}

class _ExtraEventScreenState extends State<ExtraEventScreen> {
  String? selectedValue;
  String? selectedValue2;
  String? selectedValue3;
  final TextEditingController dataController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController progressInfoController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  File? firstImage;
  File? secondImage;

  @override
  void initState() {
    dataController.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
    if (!widget.isCreate) {
      setState(() {
        selectedValue = widget.eventModel?.leadingStatus ?? 'PENDING';
        selectedValue2 = widget.eventModel?.followingStatus ?? 'PENDING';
        selectedValue3 = widget.userInfoModel.id.toString();
        dataController.text = DateFormat('dd.MM.yyyy').format(widget.eventModel?.executionDate ?? DateTime.now());
        descriptionController.text = widget.eventModel?.title ?? '';
        commentController.text = widget.eventModel?.description ?? '';
        progressInfoController.text = widget.eventModel?.progressInfo ?? '';
      });
    } else {
      selectedValue = 'PENDING';
      selectedValue2 = 'PENDING';
    }
    super.initState();
  }

  // Create separate LayerLinks for each dropdown
  final LayerLink _layerLink1 = LayerLink();
  final LayerLink _layerLink2 = LayerLink();
  final LayerLink _layerLink3 = LayerLink();

  // Your existing lists for dropdown items
  final List<Map<String, String>> items = [
    {'value': 'SEMIANNUALLY', 'label': '6 месяцев'},
    {'value': 'ANNUALLY', 'label': '12 месяцев'},
    {'value': 'QUARTERLY', 'label': '3 месяцев'},
    {'value': 'MONTHLY', 'label': '1 месяц'},
    {'value': 'ONCE', 'label': 'Прекратить сервис'},
  ];

  final List<Map<String, String>> status = [
    {'value': 'PENDING', 'label': 'Запланировано'},
    {'value': 'PROGRESS', 'label': 'Выполнено'},
    {'value': 'DONE', 'label': 'Выполнено'},
  ];

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
                    text: widget.isCreate ? 'Создать событие' : 'Редактировать событие',
                    onTap: () async {
                      if (widget.isCreate) {
                        String? firstImId;
                        if (firstImage != null) {
                          firstImId = await uploadImage(firstImage!, context);
                        }
                        String? secondImId;
                        if (secondImage != null) {
                          secondImId = await uploadImage(secondImage!, context);
                        }

                        BlocUtils.eventBloc.add(AddEvEvent(
                            eventModel: EventModel(
                          id: 0,
                          leaderUserId: 10,
                          followingUserId: int.parse(selectedValue3 ?? '0'),
                          title: descriptionController.text,
                          description: commentController.text,
                          assignedDate: DateTime.now(),
                          executionDate: DateFormat('dd.MM.yyyy').parse(dataController.text),
                          endDate: null,
                          address: widget.userInfoModel.address ?? '',
                          eventType: 'EMERGENCY',
                          repeatPeriod: 'ONCE',
                          comment: commentController.text,
                          progressInfo: progressInfoController.text,
                          followingStatus: selectedValue2,
                          leadingStatus: selectedValue,
                          imageIds: firstImId != null && secondImId != null
                              ? [firstImId, secondImId]
                              : firstImId != null
                                  ? [firstImId]
                                  : secondImId != null
                                      ? [secondImId]
                                      : [],
                        )));
                      } else {
                        BlocUtils.eventBloc.add(UpdateEvEvent(
                            eventModel: EventModel(
                                id: widget.eventModel?.id ?? 0,
                                leaderUserId: widget.eventModel?.leaderUserId ?? 0,
                                followingUserId: widget.eventModel?.followingUserId ?? 0,
                                title: descriptionController.text,
                                comment: commentController.text,
                                followingStatus: selectedValue2,
                                leadingStatus: selectedValue,
                                progressInfo: progressInfoController.text,
                                description: commentController.text,
                                assignedDate: widget.eventModel?.assignedDate ?? DateTime.now(),
                                executionDate: DateFormat('dd.MM.yyyy').parse(dataController.text),
                                endDate: widget.eventModel?.endDate ?? DateTime.now(),
                                address: widget.eventModel?.address ?? '',
                                eventType: widget.eventModel?.eventType ?? '',
                                repeatPeriod: selectedValue ?? 'ONCE',
                                imageIds: [])));
                      }

                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);
                    },
                    gradient: DColor.primaryGreenGradient,
                  ),
                  const SizedBox(height: 20),
                  DCustomButton(
                    text: 'Назад',
                    onTap: () {
                      AutoRouter.of(context).maybePop();
                    },
                    color: DColor.greyColor,
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
              widget.isCreate ? 'Создать событие' : 'Редактировать событие',
              style: DTextStyle.primaryText.copyWith(fontSize: 18),
            ),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              child: const Icon(Icons.search, color: Colors.black),
              onTap: () {},
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/settings.svg'),
                  onPressed: () {},
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
        body: BlocConsumer<MainBloc, MainState>(
          builder: (context, state) => state.status == Status.success
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            // height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: DColor.unselectedColor,
                            ),
                            child: Row(
                              children: [
                                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13, top: 5),
                                    child: Text(
                                      'Обьект',
                                      style: DTextStyle.primaryText.copyWith(color: DColor.greyUnselectedColor, fontWeight: FontWeight.w700, fontSize: 11),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13, top: 5, bottom: 5),
                                    child: Text(
                                      '${widget.userInfoModel.name}\n${widget.userInfoModel.address}\n${widget.userInfoModel.location}',
                                      style: DTextStyle.primaryText.copyWith(fontSize: 14),
                                    ),
                                  ),
                                ]),
                              ],
                            )),
                        const SizedBox(height: 20),
                        DCustomTextLableField(
                          readOnly: false,
                          initialText: dataController.text,
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                          controller: dataController,
                          label: 'Дата',
                          // hint: 'Дата',
                        ),
                        const SizedBox(height: 20),
                        DCustomTextLableField(
                          readOnly: false,
                          initialText: descriptionController.text,
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                          controller: descriptionController,
                          label: 'Добавьте описание события*',
                        ),
                        const SizedBox(height: 20),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: DColor.unselectedColor,
                            ),
                            child: Row(
                              children: [
                                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13, top: 5, bottom: 5),
                                    child: Text(
                                      'Фото',
                                      style: DTextStyle.primaryText.copyWith(color: DColor.greyUnselectedColor, fontWeight: FontWeight.w700, fontSize: 11),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 13, top: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 6),
                                            child: DPhotoPickerWidget(
                                              height: 60,
                                              width: 60,
                                              onImagePicked: (File img) {
                                                setState(() {
                                                  firstImage = img;
                                                });
                                              },
                                            ),
                                          ),
                                          if (firstImage != null)
                                            DPhotoPickerWidget(
                                              height: 60,
                                              width: 60,
                                              onImagePicked: (File img) {
                                                setState(() {
                                                  secondImage = img;
                                                });
                                              },
                                            ),
                                        ],
                                      )),
                                ]),
                              ],
                            )),
                        const SizedBox(height: 20),
                        DDropdownButtonWidget(
                          readOnly: widget.isCreate,
                          text: 'Статус Ведущего',
                          items: status,
                          selectedValue: selectedValue,
                          onSelectCountry: (String country) {
                            setState(() {
                              selectedValue = country;
                            });
                          },
                          layerLink: _layerLink1, // Pass the second LayerLink here
                        ),
                        const SizedBox(height: 20),
                        DDropdownButtonWidget(
                          readOnly: widget.isCreate,
                          text: 'Статус Ведомого',
                          items: status,
                          selectedValue: selectedValue2,
                          onSelectCountry: (String country) {
                            setState(() {
                              selectedValue2 = country;
                            });
                          },
                          layerLink: _layerLink2, // Pass the second LayerLink here
                        ),
                        const SizedBox(height: 20),
                        DCustomTextLableField(
                          readOnly: false,
                          initialText: progressInfoController.text,
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                          controller: progressInfoController,
                          label: 'Выполненные работы*',
                        ),
                        const SizedBox(height: 20),
                        DCustomTextLableField(
                          readOnly: false,
                          initialText: commentController.text,
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                          controller: commentController,
                          label: 'Комментарий',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          listener: (context, state) {},
        ));
  }
}
