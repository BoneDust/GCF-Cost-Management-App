import 'dart:ui';

import 'package:cm_mobile/bloc/client_bloc.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/model/api_response.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/client/clients_screen.dart';
import 'package:cm_mobile/screen/users/users_screen.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddEditProjectScreen extends StatefulWidget {
  final bool isEditing;
  final Project project;

  const AddEditProjectScreen({Key key, this.isEditing = false, this.project})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddEditProjectScreenState();
  }
}

class _AddEditProjectScreenState extends State<AddEditProjectScreen> {
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  DateTime startDate;
  DateTime endDate;

  ProjectsBloc projectsBloc;
  UserBloc userBloc;
  ClientBloc clientBloc;

  TextEditingController nameController = TextEditingController();
  TextEditingController estimatedCostController = TextEditingController();
  TextEditingController teamSizeController = TextEditingController();

  bool _isLoading = false;

  User _selectedForeman;

  Client _selectedClient;

  double _sizeValue = 1.0;

  String _status;

  @override
  void initState() {
    projectsBloc = ProjectsBloc(ApiService());

    if (widget.isEditing) {
      userBloc = UserBloc(ApiService());
      clientBloc = ClientBloc(ApiService());

      userBloc.outUser.listen((user) {
        setState(() {
          _selectedForeman = user;
        });
      });

      clientBloc.outClient.listen((client) {
        setState(() {
          _selectedClient = client;
        });
      });

      projectsBloc.outUpdatedProject
          .listen((project) => finishedAddingProject(project));

      fillFormsWithProjectData();
    } else {
      projectsBloc.outAddedProject
          .listen((project) => finishedAddingProject(project));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(widget.isEditing ? "edit project" : "create a project"),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    widget.isEditing ? "SAVE" : "CREATE",
                  ),
                  shape: CircleBorder(),
                  onPressed: widget.isEditing ? updateProject : _createProject)
            ],
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "name",
                        ),
                      ),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: TextFormField(
                        controller: estimatedCostController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: "estimated cost",
                          prefix: Text("R"),
                        ),
                      ),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: _foremanFormField(),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: _clientFormField(),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: _sizeSliderFormField(),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        decoration: InputDecoration(labelText: 'start date'),
                        onChanged: (dt) => setState(() => startDate = dt),
                      ),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        decoration: InputDecoration(labelText: 'end date'),
                        onChanged: (dt) => setState(() => endDate = dt),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        _isLoading ? _loadingIndicator() : Column()
      ],
    );
  }

  Widget _sizeSliderFormField() {
    return FormField<User>(
      validator: (value) {
        if (value == null) {
          return "select foreman";
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<User> state,
      ) {
        return GestureDetector(
          onTap: () {
            _showUsersSelectMenu();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "team size",
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
                          activeColor: Colors.blueGrey,
                          min: 1.0,
                          max: 30.0,
                          onChanged: (newRating) {
                            setState(() => _sizeValue = newRating);
                          },
                          value: _sizeValue,
                        ),
                      ),
                      Text(
                        _sizeValue.toInt().toString(),
                        style: TextStyle(fontSize: 20),
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
          ),
        );
      },
    );
  }

  Widget _foremanFormField() {
    return FormField<User>(
      validator: (value) {
        if (value == null) {
          return "select foreman";
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<User> state,
      ) {
        return GestureDetector(
          onTap: () {
            _showUsersSelectMenu();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new InputDecorator(
                  decoration: const InputDecoration(
                      labelText: "foreman user",
                      contentPadding: EdgeInsets.all(10.0),
                      isDense: true,
                      icon: CircleAvatar(
                        backgroundImage: AssetImage("assets/avatar.png"),
                      )),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_selectedForeman == null
                            ? "select foreman"
                            : _selectedForeman.fullName)
                      ],
                    ),
                  )),
              SizedBox(height: 5.0),
              Text(
                state.hasError ? state.errorText : '',
                style:
                    TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _clientFormField() {
    return FormField<Client>(
      validator: (value) {
        if (value == null) {
          return "select client";
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<Client> state,
      ) {
        return GestureDetector(
          onTap: () {
            _showClientSelectMenu();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "client user",
                    contentPadding: EdgeInsets.all(10.0),
                    isDense: true,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_selectedClient == null
                            ? "select client "
                            : _selectedClient.name)
                      ],
                    ),
                  )),
              SizedBox(height: 5.0),
              Text(
                state.hasError ? state.errorText : '',
                style:
                    TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
              ),
            ],
          ),
        );
      },
    );
  }

  void finishedAddingProject(ApiResponse apiResponse) {
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.isSuccess)
      Navigator.of(context).pop(apiResponse);
    else
      onAddProjectError(apiResponse.error);
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

  Project createProject() => Project(
      name: nameController.text,
      teamSize: _sizeValue.toInt(),
      startDate: startDate,
      endDate: endDate,
      foreman: _selectedForeman,
      status: "Incomplete",
      estimatedCost: double.parse(estimatedCostController.text),
      expenditure: 0.0,
      clientId: _selectedClient.id,
      userId: _selectedForeman.id);

  void _showUsersSelectMenu() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UsersScreen(
              title: "select user",
              userTileFunction: onUserSelected,
              showTabs: false,
            )));
  }

  onUserSelected(
    BuildContext context,
    User user,
  ) {
    Navigator.of(context).pop();
    setState(() {
      _selectedForeman = user;
    });
  }

  void _showClientSelectMenu() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ClientsScreen(
              title: "select client",
              userTileFunction: onClientSelected,
            )));
  }

  onClientSelected(
    BuildContext context,
    Client client,
  ) {
    Navigator.of(context).pop();
    setState(() {
      _selectedClient = client;
    });
  }

  onAddProjectError(error) {
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
                    _createProject();
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

  void _createProject() {
    setState(() {
      _isLoading = true;
    });
    projectsBloc.addProject(createProject());
  }

  void fillFormsWithProjectData() {
    nameController.text = widget.project.name;
    _sizeValue = widget.project.teamSize.toDouble();
    startDate = widget.project.startDate;
    endDate = widget.project.endDate;
    _status = widget.project.status;
    estimatedCostController.text = widget.project.estimatedCost.toString();
    userBloc.getUser(widget.project.userId);
    clientBloc.getClient(widget.project.clientId);
  }

  void updateProject() {
    setState(() {
      _isLoading = true;
    });
    projectsBloc.updateProject(getUpdatedProject());
  }

  Project getUpdatedProject() {
    Project project = createProject();
    project.id = widget.project.id;
    project.expenditure = widget.project.expenditure;
    project.status = widget.project.status;
    return project;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = new NumberFormat("###,###.###", "pt-br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
