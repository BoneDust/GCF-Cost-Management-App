import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/image_utils.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class MenuProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[_Content()],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    return Container(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(top: 50.0),
            child: Container(
              margin: EdgeInsets.only(top: 100.0),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text(user.name + " " + user.surname),
                  Text(user.privilege.toString())
                ],
              ),
            ),
          ),
          Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(ImageUtils.getAvatarPicture(context)),
                      fit: BoxFit.cover))),
        ],
      ),
    );
  }


}
