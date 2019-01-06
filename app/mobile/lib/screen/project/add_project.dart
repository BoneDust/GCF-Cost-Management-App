import 'dart:ui';

import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/data/dummy_data.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddProjectScreenState();
  }
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  List<User> _foremans = DummyData.foremanUsers;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  DateTime startDate;
  DateTime endDate;

  ProjectsBloc projectsBloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController estimatedCostController = TextEditingController();
  TextEditingController teamSizeController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    projectsBloc = ProjectsBloc(ApiService());
    projectsBloc.outAddedProject
        .listen((project) => finishedAddingProject(project));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("create a project"),
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
                    projectsBloc.addProject(project());
                  })
            ],
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: <Widget>[
              Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "name",
                        ),
                      ),
                      _dropDownFormField(),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: "description"),
                      ),
                      TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "estimated cost",
                        ),
                      ),
                      TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "team size",
                        ),
                      ),
                      DateTimePickerFormField(
                        format: dateFormat,
                        decoration: InputDecoration(labelText: 'Date'),
                        onChanged: (dt) => setState(() => startDate = dt),
                      ),
                      DateTimePickerFormField(
                        format: dateFormat,
                        decoration: InputDecoration(labelText: 'Date'),
                        onChanged: (dt) => setState(() => endDate = dt),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        _isLoading ? _loadingIndicator() : Column()
      ],
    );
  }

  User _foremanUser;
  Widget _dropDownFormField() {
    return FormField<User>(
      validator: (value) {
        if (value == null) {
          return "Select your area";
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<User> state,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new InputDecorator(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                labelText: 'foreman',
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<User>(
                  isExpanded: true,
                  hint: new Text("select foreman"),
                  value: _foremanUser,
                  onChanged: (User newValue) {
                    state.didChange(newValue);
                    setState(() {
                      _foremanUser = newValue;
                    });
                  },
                  items: _foremans.map((User value) {
                    return new DropdownMenuItem<User>(
                        child: new Text(value.name), value: value);
                  }).toList(),
                ),
              ),
            ),
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

  void finishedAddingProject(Project project) {
    setState(() {
      _isLoading = false;
    });
    if (project != null) Navigator.of(context).pop();
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

  Project project() => Project(
        name: nameController.text,
        description: descriptionController.text,
        teamSize: 23,
        startDate: startDate,
        endDate: endDate,
        foreman: _foremanUser,
        estimatedCost: 34,
      );
}
