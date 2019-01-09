import 'package:cm_mobile/bloc/client_bloc.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/client/client_details_card.dart';
import 'package:cm_mobile/screen/users/user_details_card.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  final Client client;

  const ClientScreen({Key key, @required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ClientScreen(
        client: client,
      ),
    );
  }
}

class _ClientScreen extends StatelessWidget {
  final Client client;

  const _ClientScreen({Key key, @required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(client.name),
              centerTitle: false,
              background: Image(
                image: AssetImage("assets/images.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body:ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          children: <Widget>[
            _ClientProjectsCard(),
            ClientDetailsCard(client: client),
          ],
        ),
    );
  }
}

class _ClientProjectsCard extends StatelessWidget {
  ClientsBloc clientsBloc;

  _ClientProjectsCard() {
    clientsBloc = ClientsBloc(ApiService());
    clientsBloc.query.add("");
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: clientsBloc.results,
      initialData: <Client>[],
      builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 10), child: Text("projects", style: TextStyle(color: Colors.blueGrey, fontSize: 30),),),
            Card(
                elevation: 5,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.take(3).map((client) {
                    return  ListTile(
                      title: Text(client.name),
                    );
                  }).toList(),
                ))
          ],
        );
      },
    );
  }
}
