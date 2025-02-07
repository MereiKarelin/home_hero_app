// import 'dart:math';

import 'package:auto_route/auto_route.dart';
// import 'package:datex/data/models/event_model.dart';
// import 'package:datex/features/core/d_action_button.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/core/d_info_card.dart';
import 'package:datex/features/core/d_text_style.dart';
// import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/features/main/bloc/main_bloc.dart';
import 'package:datex/utils/app_router.gr.dart';
// import 'package:datex/features/main/widgets/calendar_widget.dart';
// import 'package:datex/features/main/widgets/linear_calendar_widget.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:injectable/injectable.dart';

@RoutePage()
// ignore: must_be_immutable
class UncomingEventsScreen extends StatefulWidget {
  const UncomingEventsScreen({
    super.key,
  });

  @override
  State<UncomingEventsScreen> createState() => _UncomingEventsScreenState();
}

class _UncomingEventsScreenState extends State<UncomingEventsScreen> {
  @override
  void initState() {
    BlocUtils.mainBloc.add(MainStartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DCustomButton(
                  text: 'Создать событие',
                  onTap: () {
                    AutoRouter.of(context).push(AddEventRoute(isCreate: true));
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
                'Предстоящие события',
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
        body: BlocConsumer<MainBloc, MainState>(
          builder: (context, state) => SingleChildScrollView(
              child: state.status == Status.success
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(12),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.todayEvents.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // Фильтруем события для выбранной даты
                            final filteredEvents = state.todayEvents;

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
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        )
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
          listener: (BuildContext context, state) {},
        ));
  }
}
