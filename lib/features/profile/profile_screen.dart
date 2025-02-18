import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_custom_text_lable_field.dart';
import 'package:homehero/features/core/d_image_picker_widget.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/following/following_screen.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool onlyRead = true;
  String? imageUrl;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Container(
              color: DColor.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DCustomButton(
                    text: 'Редактировать',
                    onTap: () async {
                      setState(() {
                        onlyRead = false;
                      });
                    },
                    gradient: onlyRead ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
                  ),
                  const SizedBox(height: 20),
                  DCustomButton(
                    text: 'Сохранить',
                    onTap: () async {
                      if (!onlyRead) {
                        if (image != null) {
                          imageUrl = await uploadImage(image!, context);
                        }
                        BlocUtils.mainBloc.add(UpdateUserInfoEvent(
                            userInfoModel: UserInfoModel(
                                name: nameController.text,
                                number: numberController.text,
                                address: addressController.text,
                                imageId: imageUrl,
                                id: 0,
                                birthDate: birthDateController.text,
                                url: urlController.text,
                                email: emailController.text,
                                description: descriptionController.text,
                                location: '')));
                      }
                      setState(() {
                        onlyRead = true;
                      });
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
              'Личный кабинет',
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
                        DProfilePhotoPickerWidget(
                          imageId: state.userInfo?.imageId,
                          onImagePicked: (file) {
                            image = file;
                          },
                        ),
                        const SizedBox(height: 20),
                        DCustomTextLableField(
                          initialText: state.userInfo?.name ?? '',
                          controller: nameController,
                          // label: '',
                          label: 'ФИО или юридическое лицо*',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                          readOnly: onlyRead,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DCustomTextLableField(
                          readOnly: onlyRead,
                          initialText: state.userInfo?.birthDate ?? '',
                          controller: birthDateController,
                          // label: '',
                          label: 'Дата рождения*',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DCustomTextLableField(
                          readOnly: onlyRead,
                          initialText: state.userInfo?.address ?? '',
                          controller: addressController,
                          // label: '',
                          label: 'Юридический адрес',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DCustomTextLableField(
                          readOnly: true,
                          initialText: state.userInfo?.number ?? '',
                          controller: numberController,
                          // label: '',
                          label: 'Номер телефона*',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DCustomTextLableField(
                          readOnly: onlyRead,
                          initialText: state.userInfo?.email ?? '',
                          controller: emailController,
                          label: 'Почта',
                          // hint: 'Почта',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DCustomTextLableField(
                          readOnly: onlyRead,
                          initialText: state.userInfo?.description ?? '',
                          controller: descriptionController,
                          // label: '',
                          label: 'Оказываемые услуги',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DCustomTextLableField(
                          readOnly: onlyRead,
                          initialText: state.userInfo?.url ?? '',
                          controller: urlController,
                          // label: '',
                          label: 'Ссылка',
                          textStyle: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
          listener: (context, state) {},
        ));
  }
}
