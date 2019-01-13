import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/model_status.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/screen/client/add_client_screen.dart';
import 'package:cm_mobile/screen/client/client_screen.dart';
import 'package:cm_mobile/screen/client/client_tile.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
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
  GenericBloc<Client> clientsBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Client> _clients;
  List<Client> _filteredClients;
  @override
  void initState() {
    clientsBloc = GenericBloc<Client>();
    clientsBloc.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: StreamBuilder<List<Client>>(
        key: PageStorageKey("client"),
        stream: clientsBloc.outItems,
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          _clients = snapshot.data;
          filterClients(false);
          return snapshot.data != null
              ? _buildBody()
              : LoadingIndicator();
        },
      ),
      floatingActionButton: Theme(
          data: themeData.copyWith(accentColor: Colors.white),
          child: FloatingActionButton(
            onPressed: () => _navigateAndDisplayCreation(),
            child: Icon(
              Typicons.plus_outline,
              color: Colors.green,
            ),
          )),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ClientTile(
          client: _filteredClients[index],
          function: widget.userTileFunction,
          parent: this,
        );
      },
      itemCount: _filteredClients.length,
    );
  }

  _navigateAndDisplayCreation() async {
    final result =  await         Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditClientScreen()));
    if (result is Client) {
      setState(() {
        _clients.insert(0, result);
      });
      _scaffoldKey.currentState..showSnackBar(SnackBar(content: Text("client successfully created"), backgroundColor: Colors.green));
    }
  }

  navigateAndDisplayClient(BuildContext context, Client client) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClientScreen(client : client)));

    if (result is ModelStatus && result.status != ModelStatusType.UNCHANGED) {
      if (result.status == ModelStatusType.UPDATED) {
        int index = _clients.indexOf(client);
        setState(() {
          _clients[index] = result.model;
        });
      } else {
        _clients.remove(client);
        filterClients(true);

        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("client successfully deleted"),
            backgroundColor: Colors.green));
      }
    }
  }

  void filterClients([bool isSetState = false]) {
    void filter() {
      _filteredClients = _clients;
    }

    if (isSetState) {
      setState(() {
        setState(() {
          filter();
        });
      });
    } else
      filter();
  }
}
