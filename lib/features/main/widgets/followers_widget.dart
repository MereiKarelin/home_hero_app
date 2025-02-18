import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/utils/remote_constants.dart';
import 'package:flutter/material.dart';

class UsersListWidget extends StatelessWidget {
  final List<UserInfoModel> users;

  const UsersListWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    // ListView.separated для разделителей между карточками
    return ListView.separated(
      itemCount: users.length,
      // Отступ между элементами
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final user = users[index];
        return _UserCard(user: user);
      },
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserInfoModel user;

  const _UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Можно для красоты обернуть в Card или DecoratedBox
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // тень
        border: Border.all(color: DColor.greyUnselectedColor, width: 0.2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(31, 171, 171, 171),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          // Аватар
          CircleAvatar(
            radius: 24,
            backgroundImage: user.imageId != null ? NetworkImage('${RemoteConstants.baseUrl}/upload/uploads/${user.imageId}') : null,
          ),
          SizedBox(width: 12),
          // Две строки (ID вверху, ФИО внизу)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID ${user.id}',
                style: DTextStyle.boldBlackText,
              ),
              SizedBox(height: 4),
              Text(
                user.name ?? '',
                style: DTextStyle.primaryText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
