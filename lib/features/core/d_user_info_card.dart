import 'package:datex/data/models/user_info_model.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/utils/remote_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DUserInfoCard extends StatelessWidget {
  final UserInfoModel userInfoModel;
  const DUserInfoCard({super.key, required this.userInfoModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: DColor.orangeUnselectedColor,
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
                backgroundImage: userInfoModel.imageId != null ? NetworkImage('${RemoteConstants.baseUrl}/upload/uploads/${userInfoModel.imageId}') : null,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID${userInfoModel.id}',
                    style: DTextStyle.boldBlackText.copyWith(fontSize: 18),
                  ),
                  if (userInfoModel.name != null) Text('${userInfoModel.name}', style: DTextStyle.primaryText.copyWith(fontWeight: FontWeight.w500)),
                  if (userInfoModel.address != null) Text('${userInfoModel.address}', style: DTextStyle.primaryText.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 16,
                      backgroundColor: DColor.unselectedColor,
                      child: Icon(
                        Icons.delete,
                        color: DColor.greyColor,
                        size: 16,
                      )),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: DColor.unselectedColor,
                    child: Icon(
                      Icons.link,
                      color: DColor.greyColor,
                      size: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
