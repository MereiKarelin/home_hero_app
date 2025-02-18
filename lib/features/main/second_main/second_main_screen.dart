import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/features/core/d_action_button.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_info_card.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/features/main/widgets/calendar_widget.dart';
import 'package:homehero/features/main/widgets/drawer_widget.dart';
import 'package:homehero/features/main/widgets/linear_calendar_widget.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

@RoutePage()
// ignore: must_be_immutable
class SecondMainScreen extends StatefulWidget {
  DateTime selectedDate;
  SecondMainScreen({super.key, required this.selectedDate});

  @override
  State<SecondMainScreen> createState() => _SecondMainScreenState();
}

class _SecondMainScreenState extends State<SecondMainScreen> {
  @override
  void initState() {
    // if (mounted) {
    // WidgetsBinding.instance.addObserver(this);

    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DCustomButton(
            text: 'Назад',
            onTap: () {
              AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
            },
            gradient: DColor.primaryGreenGradient,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Открытие Drawer
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/logo/app_icon.png'),
              height: 60,
            ),
          ),
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
        body: BlocConsumer<MainBloc, MainState>(
          builder: (context, state) => SingleChildScrollView(
              child: state.status == Status.success
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CalendarSlider(
                              events: state.events,
                              onDateSelected: (value) => setState(() {
                                widget.selectedDate = value;
                              }),
                              selectedDate: widget.selectedDate,
                            ),
                          ),
                        ),
                        // Фильтрация событий на основе выбранной даты
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
                          child: Text(
                            ' На сегодня запланировано',
                            style: DTextStyle.boldBlackText.copyWith(fontSize: 16),
                          ),
                        ),

                        ListView.builder(
                          padding: const EdgeInsets.all(12),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.events
                              .where((event) =>
                                  event.executionDate.year == widget.selectedDate.year &&
                                  event.executionDate.month == widget.selectedDate.month &&
                                  event.executionDate.day == widget.selectedDate.day)
                              .toList()
                              .length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // Фильтруем события для выбранной даты
                            final filteredEvents = state.events
                                .where((event) =>
                                    event.executionDate.year == widget.selectedDate.year &&
                                    event.executionDate.month == widget.selectedDate.month &&
                                    event.executionDate.day == widget.selectedDate.day)
                                .toList();

                            final event = filteredEvents[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: DInfoCard(
                                eventModel: event,
                                onTap: () {},
                                color: event.eventType == "REGULAR" ? DColor.greenSecondColor : DColor.redUnselectedColor,
                                borderColor: event.eventType == "REGULAR" ? DColor.greenColor : DColor.redColor,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
          listener: (BuildContext context, state) {},
        ));
  }
}
