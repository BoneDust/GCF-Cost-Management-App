import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/cupertino.dart';

class ImageUtils{
  static String getAvatarPicture(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    if (user.image != null && user.image.isNotEmpty)
      return user.image;
    return "assets/avatar.png";
  }
}