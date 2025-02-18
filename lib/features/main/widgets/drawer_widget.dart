import 'package:auto_route/auto_route.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/features/main/widgets/followers_widget.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:homehero/utils/remote_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool followers = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: DColor.whiteColor,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) => state.status == Status.success
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: DColor.greenUnselectedColor,
                            backgroundImage: state.userInfo?.imageId != null
                                ? NetworkImage('${RemoteConstants.baseUrl}/upload/uploads/${state.userInfo?.imageId ?? ''}')
                                : null,
                            child: state.userInfo?.imageId != null
                                ? const SizedBox()
                                : Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 34,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.userName ?? '',
                            style: DTextStyle.boldBlackText,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.userType == "LEADING"
                              ? Text(
                                  'Ведущий',
                                  style: DTextStyle.boldBlackText.copyWith(color: DColor.greenColor, fontSize: 12),
                                )
                              : Text('Ведомый', style: DTextStyle.boldBlackText.copyWith(color: DColor.greenColor, fontSize: 12)),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(1), color: DColor.blackTextColor),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("ID: ${state.userId}", style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                          state.userType == "LEADING"
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      followers = !followers;
                                    });
                                  },
                                  child: Icon(
                                    followers ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                                    color: DColor.greyUnselectedColor,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      state.userType == "LEADING" && followers
                          ? UsersListWidget(
                              users: state.followers,
                            )
                          : const SizedBox(),

                      SizedBox(
                        height: followers ? 15 : 50,
                      ),
                      ListTile(
                        leading: SvgPicture.asset('assets/main.svg'),
                        title: Text(
                          'Главная',
                          style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          // Navigate to Home screen
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),
                      // ListTile(
                      //   leading: SvgPicture.asset('assets/users.svg'),
                      //   title: Text(
                      //     'Список ведомых',
                      //     style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     size: 15,
                      //   ),
                      //   onTap: () {
                      //     AutoRouter.of(context).push(FollowingRoute());
                      //     // Navigate to Home screen
                      //     // Navigator.pushReplacementNamed(context, '/home');
                      //   },
                      // ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),
                      ListTile(
                        leading: SvgPicture.asset('assets/today.svg'),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Предстоящие события ',
                              style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            if ((state.todayEvents.length - state.todayExtraEvents.length) > 0)
                              Text(
                                (state.todayEvents.length - state.todayExtraEvents.length).toString(),
                                style: DTextStyle.blueText.copyWith(fontSize: 12),
                              ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          AutoRouter.of(context).push(UncomingEventsRoute());
                          // Navigate to Home screen
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),
                      ListTile(
                        leading: SvgPicture.asset('assets/exstra.svg'),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Экстренно ',
                              style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            if (state.todayExtraEvents.isNotEmpty)
                              Text(
                                state.todayExtraEvents.length.toString(),
                                style: DTextStyle.blueText.copyWith(fontSize: 12),
                              ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          AutoRouter.of(context).push(UncomingEventsRoute());
                          // Navigate to Home screen
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),
                      ListTile(
                        leading: SvgPicture.asset('assets/archive.svg'),
                        title: Text(
                          'Архив',
                          style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onTap: () {
                          // Navigate to Home screen
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),
                      ListTile(
                        leading: SvgPicture.asset('assets/my_info.svg'),
                        title: Text(
                          'Личные данные',
                          style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onTap: () {
                          AutoRouter.of(context).push(ProfileRoute());
                          // Navigate to Home screen
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      // Container(
                      //     height: 0.2,
                      //     decoration: BoxDecoration(
                      //       color: DColor.greyUnselectedColor,
                      //     )),
                      // if (state.userType == "LEADING")
                      //   ListTile(
                      //     leading: SvgPicture.asset('assets/delete_user.svg'),
                      //     title: Text(
                      //       'Удалить/Передать',
                      //       style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 15,
                      //     ),
                      //     onTap: () {
                      //       // Navigate to Home screen
                      //       // Navigator.pushReplacementNamed(context, '/home');
                      //     },
                      //   ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),
                      if (state.userType == "LEADING")
                        ListTile(
                          leading: SvgPicture.asset('assets/check.svg'),
                          title: Text(
                            'Чеки',
                            style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                          onTap: () {
                            // Navigate to Home screen
                            // Navigator.pushReplacementNamed(context, '/home');
                          },
                        ),
                      // Container(
                      //     height: 0.2,
                      //     decoration: BoxDecoration(
                      //       color: DColor.greyUnselectedColor,
                      //     )),
                      // if (!(state.userType == "LEADING"))
                      //   ListTile(
                      //     leading: SvgPicture.asset('assets/person.svg'),
                      //     title: Text(
                      //       'О ведущем',
                      //       style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_rounded,
                      //       size: 15,
                      //     ),
                      //     onTap: () {
                      //       // Navigate to Home screen
                      //       // Navigator.pushReplacementNamed(context, '/home');
                      //     },
                      //   ),
                      // Container(
                      //     height: 0.2,
                      //     decoration: BoxDecoration(
                      //       color: DColor.greyUnselectedColor,
                      //     )),
                      // ListTile(
                      //   leading: SvgPicture.asset('assets/about_us.svg'),
                      //   title: Text(
                      //     'О приложении',
                      //     style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios_rounded,
                      //     size: 15,
                      //   ),
                      //   onTap: () {
                      //     // Navigate to Home screen
                      //     // Navigator.pushReplacementNamed(context, '/home');
                      //   },
                      // ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),

                      ListTile(
                        leading: SvgPicture.asset('assets/exit.svg'),
                        title: Text(
                          'Выход',
                          style: DTextStyle.primaryText.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                        onTap: () {
                          sharedDb.remove('token');
                          AutoRouter.of(context).push(SplashRoute(isWelcomScreen: false));
                          // Navigate to Home screen
                          // Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      Container(
                          height: 0.2,
                          decoration: BoxDecoration(
                            color: DColor.greyUnselectedColor,
                          )),

                      // Logout button
                    ],
                  )
                : Row(
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
          )),
    );
  }
}
