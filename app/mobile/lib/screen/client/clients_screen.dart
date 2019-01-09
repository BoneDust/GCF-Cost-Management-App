import 'package:cm_mobile/bloc/client_bloc.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/client/client_tile.dart';
import 'package:cm_mobile/screen/users/users_tile.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';

class ClientsScreen extends StatefulWidget {
  final String title;
  final Function userTileFunction;

  const ClientsScreen({Key key, @required this.title, this.userTileFunction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClientsScreenState();
  }
}

class ClientsScreenState extends State<ClientsScreen> {
  ClientsBloc clientsBloc;

  @override
  void initState() {
    clientsBloc = ClientsBloc(ApiService());
    clientsBloc.query.add("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: StreamBuilder<List<Client>>(
        key: PageStorageKey("users"),
        stream: clientsBloc.results,
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          return snapshot.data != null
              ? _buildBody(snapshot.data)
              : _LoadingWidget();
        },
      ),
      floatingActionButton: Theme(
          data: themeData.copyWith(accentColor: Colors.white),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/create_client");
            },
            child: Icon(
              Typicons.plus_outline,
              color: Colors.green,
            ),
          )),
    );
  }

  Widget _buildBody(List<Client> data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ClientTile(
          client: data[index],
          function: widget.userTileFunction,
        );
      },
      itemCount: data.length,
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
