// import 'dart:math';

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:datex/data/models/user_info_model.dart';
import 'package:datex/features/core/d_alerts.dart';
// import 'package:datex/data/models/event_model.dart';
// import 'package:datex/features/core/d_action_button.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_coordinate_input.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/core/d_custom_text_field.dart';
import 'package:datex/features/core/d_image_picker_widget.dart';
// import 'package:datex/features/core/d_info_card.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/features/core/d_user_info_card.dart';
import 'package:datex/features/following/bloc/following_bloc.dart';
// import 'package:datex/features/core/d_text_style.dart';
// import 'package:datex/features/main/bloc/main_bloc.dart';
// import 'package:datex/utils/app_router.gr.dart';
// import 'package:datex/features/main/widgets/calendar_widget.dart';
// import 'package:datex/features/main/widgets/linear_calendar_widget.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:datex/utils/dio_client.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:datex/utils/remote_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:injectable/injectable.dart';

@RoutePage()
// ignore: must_be_immutable
class FollowingScreen extends StatefulWidget {
  const FollowingScreen({
    super.key,
  });

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  bool createFollowing = false;
  @override
  void initState() {
    BlocUtils.follofingBloc.add(GetFollowersEvent());
    super.initState();
  }

  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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
                    text: 'Создать ведомых',
                    onTap: () async {
                      if (!createFollowing) {
                        setState(() {
                          createFollowing = true;
                        });
                      } else {
                        String? imageId;
                        if (image != null) {
                          imageId = await uploadImage(image!, context);
                        }

                        BlocUtils.follofingBloc.add(CreateFollowerEvent(
                            userInfoModel: UserInfoModel(
                                name: nameController.text,
                                number: numberController.text,
                                location: locationController.text,
                                address: addressController.text,
                                imageId: imageId,
                                id: 0))); //заглушка
                      }
                    },
                    // color: DCol,
                    gradient: DColor.primaryGreenGradient),
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
                'Создать ведомых',
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
        body: BlocConsumer<FollowingBloc, FollowingState>(
          builder: (context, state) => createFollowing
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DCustomTextField(controller: nameController, label: 'ФИО или юридическое лицо*', hint: "Ввелите фио или наименование"),
                      const SizedBox(height: 15),
                      DCustomTextField(controller: numberController, label: 'Телефон*', hint: "Ввелите номер телефона"),
                      const SizedBox(height: 15),
                      DCustomTextField(controller: addressController, label: 'Адрес объекта*', hint: "Ввелите адрес"),
                      const SizedBox(height: 15),
                      DCoordinateInputWidget(
                        controller: locationController,
                      ),
                      const SizedBox(height: 15),
                      DPhotoPickerWidget(
                        onImagePicked: (File img) {
                          image = img;
                        },
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (state is FollowersLoadedState)
                        if (state.followers.isNotEmpty)
                          ListView.builder(
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.followers.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final follower = state.followers[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: DUserInfoCard(
                                  userInfoModel: follower,
                                ),
                              );
                            },
                          ),
                      if (state is FollowersLoadedState)
                        if (state.followers.isEmpty)
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(217, 216, 237, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: DColor.whiteColor,
                                      child: SvgPicture.asset('assets/galery.svg'),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                            radius: 12,
                                            backgroundColor: DColor.unselectedColor,
                                            child: Icon(
                                              Icons.delete,
                                              color: DColor.greyColor,
                                              size: 12,
                                            )),
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: DColor.unselectedColor,
                                          child: Icon(
                                            Icons.link,
                                            color: DColor.greyColor,
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                    ],
                  ),
                ),
          listener: (context, state) {
            if (state is FollowerCreatedState) {
              setState(() {
                createFollowing = false;
              });
              DAlerts.showDefaultAlert('Вы успешно создали ведомого', () {
                Navigator.pop(context);
              }, context);
            } else if (state is FollowingErrorState) {
              DAlerts.showErrorAlert(state.error, context);
            }
          },
        ));
  }
}

Future<String?> uploadImage(File img, BuildContext context) async {
  try {
    DioClient dio = getIt.get<DioClient>();
    ;
    String fileName = img.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        img.path,
        filename: fileName,
      ),
    });

    Response response = await dio.post(
      "${RemoteConstants.baseUrl}/upload", // Укажи URL своего бэкенда
      data: formData,
      options: Options(headers: {
        "Content-Type": "multipart/form-data",
      }),
    );

    // print(re)

    if (response.statusCode != 200) {
      DAlerts.showErrorAlert("Upload failed: ${response.statusMessage}", context);
      return null;
    } else {
      return response.data["fileName"];
    }
  } catch (e) {
    DAlerts.showErrorAlert("Error: $e", context);
  } finally {}
}
