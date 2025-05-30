import 'package:auto_route/auto_route.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_custom_text_field.dart';
import 'package:homehero/features/core/d_custom_text_lable_field.dart';
import 'package:homehero/features/core/d_drop_down_button.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/event/bloc/event_bloc.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
// import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddEventScreen extends StatefulWidget {
  final bool isCreate;
  final EventModel? eventModel;
  const AddEventScreen({super.key, required this.isCreate, this.eventModel});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String? selectedValue;
  String? selectedValue2;
  String? selectedValue3;
  final TextEditingController dataController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  String? type = 'LEADING';

  @override
  void initState() {
    type = sharedDb.getString('userType');
    dataController.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
    if (!widget.isCreate) {
      setState(() {
        selectedValue = widget.eventModel?.repeatPeriod ?? 'SEMIANNUALLY';
        selectedValue2 = 'PENDING';
        selectedValue3 = (widget.eventModel?.followingUserId ?? 0).toString();
        dataController.text = DateFormat('dd.MM.yyyy').format(widget.eventModel?.executionDate ?? DateTime.now());
        descriptionController.text = widget.eventModel?.title ?? '';
        commentController.text = widget.eventModel?.description ?? '';
      });
    } else {
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
                  if (type == "FOLLOWING")
                    DCustomButton(
                      text: widget.isCreate ? 'Создать событие' : 'Редактировать событие',
                      onTap: () async {
                        if (widget.isCreate) {
                          BlocUtils.eventBloc.add(AddEvEvent(
                              eventModel: EventModel(
                                  id: 0,
                                  leaderUserId: 0,
                                  followingUserId: int.parse(selectedValue3 ?? '0'),
                                  title: descriptionController.text,
                                  description: commentController.text,
                                  assignedDate: DateTime.now(),
                                  executionDate: DateFormat('dd.MM.yyyy').parse(dataController.text),
                                  endDate: DateTime.now(),
                                  address: '',
                                  eventType: 'REGULAR',
                                  repeatPeriod: selectedValue ?? 'ONCE',
                                  confirmed: false,
                                  imageIds: [])));
                        } else {
                          BlocUtils.eventBloc.add(UpdateEvEvent(
                              eventModel: EventModel(
                                  id: widget.eventModel?.id ?? 0,
                                  leaderUserId: widget.eventModel?.leaderUserId ?? 0,
                                  followingUserId: widget.eventModel?.followingUserId ?? 0,
                                  title: descriptionController.text,
                                  description: commentController.text,
                                  assignedDate: widget.eventModel?.assignedDate ?? DateTime.now(),
                                  executionDate: DateFormat('dd.MM.yyyy').parse(dataController.text),
                                  endDate: widget.eventModel?.endDate ?? DateTime.now(),
                                  address: widget.eventModel?.address ?? '',
                                  eventType: widget.eventModel?.eventType ?? '',
                                  repeatPeriod: selectedValue ?? 'ONCE',
                                  confirmed: widget.eventModel?.confirmed,
                                  imageIds: [])));
                        }

                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pop(context);
                      },
                      gradient: DColor.primaryGreenGradient,
                    ),
                  if (type == "LEADING")
                    DCustomButton(
                      text: 'Принять',
                      onTap: () async {
                        BlocUtils.mainBloc.add(AssignLeader(widget.eventModel?.id ?? 0));
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
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DCustomTextLableField(
                        readOnly: false,
                        initialText: dataController.text,
                        textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        controller: dataController,
                        label: 'Дата',
                        // hint: 'Дата',
                      ),
                      const SizedBox(height: 30),
                      DCustomTextLableField(
                        readOnly: false,
                        initialText: descriptionController.text,
                        textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        controller: descriptionController,
                        label: 'Добавьте описание события*',
                      ),
                      const SizedBox(height: 30),
                      DDropdownButtonWidget(
                        readOnly: false,
                        text: 'Статус',
                        items: status,
                        selectedValue: selectedValue2,
                        onSelectCountry: (String country) {
                          setState(() {
                            selectedValue2 = country;
                          });
                        },
                        layerLink: _layerLink2, // Pass the second LayerLink here
                      ),
                      const SizedBox(height: 30),
                      DCustomTextLableField(
                        readOnly: false,
                        initialText: commentController.text,
                        textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        controller: commentController,
                        label: 'Комментарий',
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          listener: (context, state) {},
        ));
  }
}
