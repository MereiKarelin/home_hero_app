import 'package:auto_route/auto_route.dart';
import 'package:datex/data/models/app_notifiction_model.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/features/main/widgets/drawer_widget.dart';
import 'package:datex/features/notification/bloc/notifications_bloc.dart';
import 'package:datex/utils/app_router.gr.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  final int userId;
  const NotificationsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsScreen> {
  late final NotificationsBloc _notificationsBloc;
  final ScrollController _scrollController = ScrollController();

  /// Переключатель звукового сигнала (true – звук включён)
  bool soundEnabled = true;

  @override
  void initState() {
    super.initState();
    _notificationsBloc = BlocUtils.notificationsBloc;
    _notificationsBloc.add(NotificationsFetched());
    _scrollController.addListener(_onScroll);
    soundEnabled = sharedDb.getBool('notifications') ?? true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _notificationsBloc.add(NotificationsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _onRefresh() async {
    _notificationsBloc.add(NotificationsRefreshed());
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
            _scaffoldKey.currentState?.openDrawer(); // открытие Drawer
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/logo/app_icon.svg',
            height: 50, // подберите нужный размер
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
      drawer: const CustomDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DCustomButton(
          text: 'Назад',
          onTap: () {
            AutoRouter.of(context).maybePop();
          },
          color: DColor.greyColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocConsumer<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationStatus.failure) {
            return const Center(child: Text('Ошибка загрузки уведомлений'));
          }
          if (state.status == NotificationStatus.initial && state.notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Разбиваем уведомления на непрочитанные и прочитанные
          final unreadNotifications = state.notifications.where((n) => !n.markRead).toList();
          final readNotifications = state.notifications.where((n) => n.markRead).toList();

          // Собираем список виджетов для отображения
          List<Widget> listItems = [];

          // Заголовок с переключателем "Звуковой сигнал"
          listItems.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 13, 8, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Звуковой сигнал",
                    style: DTextStyle.boldBlackText.copyWith(fontSize: 20),
                  ),
                  CupertinoSwitch(
                    value: soundEnabled,
                    onChanged: (value) {
                      setState(() {
                        soundEnabled = value;
                        sharedDb.setBool('notifications', value);
                      });
                    },
                  ),
                ],
              ),
            ),
          );

          // Блок для непрочитанных уведомлений
          if (unreadNotifications.isNotEmpty) {
            listItems.add(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "Непрочитанные уведомления",
                  style: DTextStyle.boldBlackText.copyWith(fontSize: 20),
                ),
              ),
            );
            for (var notification in unreadNotifications) {
              listItems.add(
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  color: notification.notificationType == 'EMERGENCY' ? DColor.redUnselectedColor : DColor.blueUnselectedColor,
                  child: ListTile(
                    title: Text(
                      notification.description,
                      style: DTextStyle.primaryText,
                    ),
                  ),
                ),
              );
            }
          }

          // Блок для прочитанных уведомлений
          if (readNotifications.isNotEmpty) {
            listItems.add(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "Прочитанные уведомления",
                  style: DTextStyle.boldBlackText.copyWith(fontSize: 20),
                ),
              ),
            );
            for (var notification in readNotifications) {
              listItems.add(
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  color: notification.notificationType == 'EMERGENCY' ? DColor.redUnselectedColor : DColor.unselectedColor,
                  child: ListTile(
                    title: Text(
                      notification.description,
                      style: DTextStyle.primaryText,
                    ),
                  ),
                ),
              );
            }
          }

          // Индикатор загрузки, если есть ещё страницы
          if (!state.hasReachedMax) {
            listItems.add(
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView(
              controller: _scrollController,
              children: listItems,
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
