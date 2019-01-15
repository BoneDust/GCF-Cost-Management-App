import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/activity/activities.dart';
import 'package:cm_mobile/screen/activity/activity.dart';
import 'package:cm_mobile/screen/activity/activity_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ActivitiesCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivitiesCardState();
  }
}

class _ActivitiesCardState extends State<ActivitiesCard> {
  GenericBloc<Activity> activityBloc;

  @override
  void initState() {

    activityBloc = GenericBloc<Activity>();
    User user = AppData.user;
    String filter = user.privilege == Privilege.ADMIN ? "" : "foreman_id=" + user.id.toString();
    activityBloc.getAll(filter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GenericBloc<Activity>>(
        bloc: activityBloc,
        child: StreamBuilder<List<Activity>>(
          stream: activityBloc.outItems,
          builder:
              (BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
            return snapshot.data != null
                ? _buildBody(snapshot.data)
                : _LoadingWidget();
          },
        ));
  }

  Widget _buildBody(List<Activity> activities) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExpansionTile(
            title: Text(
              "activities",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            ),
            children: [
              ActivityList(
                activities: activities.take(3).toList(),
                isScrollable: false,
              ),
              Center(child: FlatButton(onPressed:(){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ActivitiesScreen(activities: activities)));
              } , child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_down),
                  Text("all activites")
                ],)),)
            ],
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
      ),
    );
  }
}
