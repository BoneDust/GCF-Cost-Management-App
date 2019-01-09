import 'dart:ui';

import 'package:cm_mobile/bloc/project_bloc.dart';
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

class AddProjectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddProjectScreenState();
  }
}

class _AddProjectScreenState extends State<AddProjectScreen> {
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

  User _selectedForeman;

  Client _selectedClient;

  double _sizeValue = 1.0;
  String _sizeValueString = "";

  @override
  void initState() {
    projectsBloc = ProjectsBloc(ApiService());
    projectsBloc.outAddedProject
        .listen((project) => finishedAddingProject(project));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: new Text("could not create project"),
                            actions: <Widget>[
                              FlatButton(onPressed: (){}, child: Text("try again")),
                              FlatButton(onPressed: (){}, child: Text("dismiss"))                            ],
                          );
                        });
//                    setState(() {
//                      _isLoading = true;
//                    });
//                    projectsBloc.addProject(project());
                  })
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "name",
                        ),
                      ),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: "description"),
                      ),
                    ),
                    Theme(
                      data: themeData.copyWith(primaryColor: Colors.blueGrey),
                      child: TextFormField(
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
      teamSize: 6,
      startDate: startDate,
      endDate: endDate,
      foreman: _selectedForeman,
      status: "Incomplete",
      estimatedCost: 34.50,
      expenditure: 0,
      clientId: 2,
      userId: 1);

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
