import 'dart:ui';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/screen/project/loading_widget.dart';
import 'package:flutter/material.dart';

class AddEditClientScreen extends StatefulWidget {
  final bool isEditing;
  final Client client;
  const AddEditClientScreen({Key key, this.isEditing = false, this.client})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddEditClientScreenState();
  }
}

class _AddEditClientScreenState extends State<AddEditClientScreen> {
  bool _isLoading = false;
  GenericBloc<Client> clientBlocs;

  TextEditingController nameController = TextEditingController();
  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    clientBlocs = GenericBloc<Client>();

    if (widget.isEditing) {
      clientBlocs.outUpdatedItem
          .listen((client) => onClientReceived(client))
          .onError(handleError);

      fillFormsWithUserData();
    } else {
      clientBlocs.outCreateItem
          .listen((client) => onClientReceived(client))
          .onError(handleError);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                actions: <Widget>[
                  FlatButton(
                      child: Text(
                        widget.isEditing ? "SAVE" : "CREATE",
                      ),
                      shape: CircleBorder(),
                      onPressed: widget.isEditing ? updateClient : _create)
                ],
                elevation: 5,
                forceElevated: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: Text(
                      widget.isEditing ? "edit client" : "create a client"),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(5.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([_formFields()]),
                ),
              )
            ],
          ),
        ),
        _isLoading
            ? LoadingIndicator(
                text: widget.isEditing ? "saving client" : "creating client")
            : Column()
      ],
    );
  }

  void onClientReceived(Client client) {
    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop(client);
  }

  void onClientAdded(Client client) {
    setState(() {
      _isLoading = false;
    });

    if (client != null) Navigator.of(context).pop(client);
  }

  Client createClient() => Client(
        name: nameController.text,
      );

  Widget _formFields() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        new ListTile(
          title: TextFormField(
            validator: (val) => val.isEmpty ? 'Please enter client name' : null,
            controller: nameController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'full name'),
          ),
        ),
        ListTile(
          title: TextFormField(
            validator: (val) =>
                val.isEmpty ? 'Please enter contact name' : null,
            controller: _contactPersonController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: 'contact person'),
          ),
        ),
        ListTile(
          title: TextFormField(
            validator: (val) =>
                val.isEmpty ? 'Please enter contact number' : null,
            controller: _phoneNumberController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'number'),
          ),
        ),
      ],
    );
  }

  void _create() {
    setState(() {
      _isLoading = true;
    });
    clientBlocs.create(createClient());
  }

  Client getUpdatedUser() {
    Client client = createClient();
    client.id = widget.client.id;
    return client;
  }

  void fillFormsWithUserData() {
    nameController.text = widget.client.name;
    _contactPersonController.text = widget.client.contactPerson;
    _phoneNumberController.text = widget.client.contactNumber;
  }

  void updateClient() {
    setState(() {
      _isLoading = true;
    });
    Client updatedClient = getUpdatedUser();
    clientBlocs.update(updatedClient, updatedClient.id);
  }

  handleError(error) {
    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("$error"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.isEditing ? updateClient() : _create();
                  },
                  child: Text("try again")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("dismiss"))
            ],
          );
        });
  }
}
