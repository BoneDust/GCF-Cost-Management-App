import 'dart:ui';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditStageScreen extends StatefulWidget {
  final bool isEditing;

  final int projectId;

  const AddEditStageScreen({Key key, this.isEditing, this.projectId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddEditStageScreenState();
  }
}

class _AddEditStageScreenState extends State<AddEditStageScreen> {
  bool _isLoading = false;
  GenericBloc<Stage> stageBloc;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  DateTime startDate;
  DateTime endDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isStartImmediately = true;

  @override
  void initState() {
    stageBloc = GenericBloc<Stage>();
    stageBloc.outCreateItem
        .listen((client) => onClientAdded(client));


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
                        "CREATE",
                      ),
                      shape: CircleBorder(),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        stageBloc.create(createStage());
                      })
                ],
                elevation: 5,
                forceElevated: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: Text("add new stage"),
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
        _isLoading ? _loadingIndicator() : Column()

      ],
    );
  }

  void onClientAdded(Stage stage) {
    setState(() {
      _isLoading = false;
    });

    if (stage != null)
      Navigator.of(context).pop(stage);
  }

  Stage createStage() => Stage(
    name: nameController.text,
    description: _descriptionController.text,
    projectId: widget.projectId,
    startDate: _isStartImmediately ? DateTime.now() : startDate,
    endDate: endDate,
    status: _isStartImmediately ? "active" : "pending",

  );

  Widget _formFields(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        new ListTile(
          title: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'name'),
          ),
        ),
        ListTile(
          title: TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'description'),
          ),
        ),
        ListTile(
          title: TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'description'),
          ),
        ),
        ListTile(
          title: Text("start immidiately"),
          trailing:  Switch(onChanged: (bool value) {
            setState(() {
              _isStartImmediately = !_isStartImmediately;
            });
          }, value: _isStartImmediately),
        ),
        !_isStartImmediately ?
        DateTimePickerFormField(
            format: dateFormat,
            decoration: InputDecoration(labelText: 'start date'),
            onChanged: (dt) => setState(() => startDate = dt),
          ) : Column(),
        DateTimePickerFormField(
          format: dateFormat,
          decoration: InputDecoration(labelText: 'end date'),
          onChanged: (dt) => setState(() => endDate = dt),
        )

      ],
    );
  }
}

Widget _loadingIndicator() {
  return Stack(
    children: <Widget>[
      Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
      Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),
      ),
    ],
  );
}