import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/features/core/d_action_button.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_info_card.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/features/main/widgets/calendar_widget.dart';
import 'package:homehero/features/main/widgets/drawer_widget.dart'; // Убедитесь, что у вас есть этот виджет
import 'package:homehero/utils/app_router.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // если вы используете правый Drawer
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
                  AutoRouter.of(context).push(NotificationsRoute(userId: 10));
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
      drawer: const CustomDrawer(), // Добавляем сам Drawer здесь
      body: BlocConsumer<MainBloc, MainState>(
        builder: (context, state) => SingleChildScrollView(
          child: state.status == Status.success
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Календарь',
                            style: DTextStyle.boldBlackText.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomCalendarWidget(
                        events: state.events,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (state.userType != 'LEADING')
                            DActionButton(
                              text: 'Создать событие',
                              onTap: () {
                                AutoRouter.of(context).push(AddEventRoute(isCreate: true));
                              },
                              icon: const Icon(Icons.add),
                              color: DColor.greenColor,
                              width: MediaQuery.of(context).size.width / 2.3,
                            ),
                          if (state.userType != 'LEADING')
                            const SizedBox(
                              width: 5,
                            ),
                          if (state.userType != 'LEADING')
                            Expanded(
                              child: DActionButton(
                                text: 'Создать экстренное',
                                onTap: () {
                                  AutoRouter.of(context).push(ExtraEventRoute(
                                    isCreate: true,
                                    userInfoModel: state.userInfo ?? UserInfoModel(name: '', number: '', location: '', address: '', imageId: '', id: 0),
                                  ));
                                },
                                icon: const Icon(Icons.add),
                                color: DColor.greenColor,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.todayEvents.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final event = state.todayEvents[index];
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
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: DColor.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
        listener: (BuildContext context, state) {},
      ),
    );
  }
}
