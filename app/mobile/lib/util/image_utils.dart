import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/cupertino.dart';

class ImageUtils{
  static String getAvatarPicture(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    if (user.pictureUrl != null && user.pictureUrl.isNotEmpty)
      return user.pictureUrl;
    return "assets/avatar.png";
  }
}