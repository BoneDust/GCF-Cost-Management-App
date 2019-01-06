import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/image_utils.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildRoundButton(Typicons.cog_outline, "settings"),
              CircleAvatar(
                minRadius: 80,
                backgroundImage: AssetImage(ImageUtils.getAvatarPicture(context)),
              ),
              _buildRoundButton(Typicons.pencil, "edit`"),

            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child:           Column(
              children: <Widget>[
                Text(user.name + " " + user.surname, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                Text(PrivilegeType[user.privilege])
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRoundButton(IconData icon, String title) {
    return Container(
      height: 80,
      width: 80,
      child: FlatButton(onPressed: (){}, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.blueGrey,),
          Padding(padding: EdgeInsets.only(top: 7),),
          Text(title)
        ],
      ), shape: CircleBorder()),
    );
  }


}
