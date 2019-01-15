import 'dart:ui';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/project/loading_widget.dart';
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
  TextEditingController _estimatedDurationController = TextEditingController();

  bool _isStartImmediately = true;

  double _estimatedDays = 1.0;

  @override
  void initState() {
    stageBloc = GenericBloc<Stage>();
    stageBloc.outCreateItem
        .listen((client) => onStageComplete(client)).onError(handleError);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

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
                        _createStage();
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
                  delegate: SliverChildListDelegate([_formFields(themeData)]),
                ),
              )
            ],
          ),
        ),
        _isLoading ? LoadingIndicator() : Column()

      ],
    );
  }

  void onStageComplete(Stage stage) {
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
    status: _isStartImmediately ? "active" : "pending",
    estimatedDaysDuration: _estimatedDays.toInt()
  );

  Widget _formFields(ThemeData themeData){
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
        Theme(
          data: themeData.copyWith(primaryColor: themeData.primaryTextTheme.display1.color),
          child: _estimatedSliderFormField(),
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
        ListTile(
          title: DateTimePickerFormField(
            format: dateFormat,
            decoration: InputDecoration(labelText: 'start date'),
            onChanged: (dt) => setState(() => startDate = dt),
          ),
        ) : Column(),

      ],
    );
  }

  Widget _estimatedSliderFormField() {
    ThemeData themeData = Theme.of(context);

    return FormField<int>(
      validator: (value) {
        if (value == null) {
          return "select foreman";
        }
      },
      onSaved: (value) {},
      builder: (
          FormFieldState<int> state,
          ) {
        return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "estimated duration(days)",
                    contentPadding: EdgeInsets.all(10.0),
                    isDense: true,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          label: "dsf",
                          activeColor: themeData.primaryTextTheme.display1.color,
                          min: 1.0,
                          max: 31.0,
                          onChanged: (newRating) {
                            setState(() => _estimatedDays = newRating);
                          },
                          value: _estimatedDays,
                        ),
                      ),
                      Text(
                        _estimatedDays.toInt().toString(),
                        style: TextStyle(fontSize: 31),
                      )
                    ],
                  )),
              SizedBox(height: 5.0),
              Text(
                state.hasError ? state.errorText : '',
                style:
                TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
              ),
            ],
          );
      },
    );
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
                    widget.isEditing ? _updateStage() : _createStage();
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

  _updateStage() {

  }

  _createStage() {
    setState(() {
      _isLoading = true;
    });
    stageBloc.create(createStage());
  }
}
