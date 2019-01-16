import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/project/projects_screen.dart';
import 'package:cm_mobile/screen/receipt/image_viewer.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditReceiptScreen extends StatefulWidget {
  final Project project;
  final bool isEditing;

  const AddEditReceiptScreen({Key key, this.project, this.isEditing = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddReceiptState(project);
  }
}

class _AddReceiptState extends State<AddEditReceiptScreen> {
  Project _project;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();
  TextEditingController supplierController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  Widget previewImage = Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0.1, 0.4, 0.5, 1],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Colors.white,
        Colors.white24,
        Colors.white30,
        Colors.grey.withOpacity(0.5),
      ],
    )),
  );
  File _image;

  bool _isLoading = false;

  String _title = "take receipt picture";
  Color _titleColor;
  GenericBloc<Receipt> receiptBloc;

  bool _isInitializing = true;

  _AddReceiptState(this._project);
  StreamSubscription outReceiptsListener;

  @override
  void initState() {
    receiptBloc = GenericBloc<Receipt>();

    outReceiptsListener = receiptBloc.outCreateItem
        .listen((receipt) => finishedAddingReceipt(receipt));

    outReceiptsListener.onError(handleError);

    super.initState();
  }

  Receipt createReceiptObject() => Receipt(
    projectId: _project.id,
    description: descriptionController.text,
    totalCost: double.parse(totalCostController.text),
    purchaseDate: DateTime.now(),
    picture: " ",
    supplier: supplierController.text,
  );

  Future getImage(FormFieldState state) async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 1600, maxHeight: 1200);
    setState(() {
      _image = image;
      state.didChange(_image);
      previewImage = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceiptImageViewer(
                        image: _image,
                      )));
        },
        child: Image(
          image: FileImage(_image),
          fit: BoxFit.cover,
        ),
      );
    });
    print(_image.statSync());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    if (_isInitializing) {
      _titleColor = themeData.primaryTextTheme.display1.color;
      _isInitializing = false;
    }

    return Scaffold(
        body: Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                elevation: 5,
                forceElevated: true,
                pinned: true,
                expandedHeight: 200.0,
                flexibleSpace: new FlexibleSpaceBar(
                  centerTitle: true,
                  background: previewImage,
                  title: _buildRoundButton(Icons.add_a_photo),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([_receiptFields()]),
                ),
              ),
            ],
          ),
          _isLoading ? _loadingIndicator() : Column()
        ],
      ),
    ));
  }

  Widget _buildRoundButton(IconData icon) {
    return FormField<File>(
      validator: (value) {
        if (value == null) {
          _titleColor = Colors.red;
          return "select image";
        } else {
          ThemeData themeData = Theme.of(context);
          _titleColor = themeData.primaryTextTheme.display1.color;
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<File> state,
      ) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: _titleColor,
                ),
                onPressed: () {
                  getImage(state);
                }),
            Text(
              _title,
              style: TextStyle(color: _titleColor),
            )
          ],
        );
      },
    );
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

  Widget _receiptFields() {
    ThemeData themeData = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          _projectFormField(),
          TextFormField(
            validator: (val) =>
                val.isEmpty ? 'reciept amount cannot be empty' : null,
            keyboardType: TextInputType.number,
            controller: totalCostController,
            decoration: InputDecoration(labelText: "amount", prefix: Text("R")),
          ),
          TextFormField(
            validator: (val) => val.isEmpty ? 'please include supplier' : null,
            controller: supplierController,
            decoration: InputDecoration(labelText: "supplier"),
          ),
          TextFormField(
            validator: (val) =>
                val.isEmpty ? 'please describe what the reciept is for' : null,
            controller: descriptionController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: "description",
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                elevation: 10,
                color: themeData.primaryTextTheme.display1.color,
                child: Text(
                  "submit",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _createReceipt();
                  } else
                    setState(() {
                      _autoValidate = true;
                    });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _projectFormField() {
    return FormField<Project>(
      validator: (value) {
        if (value == null) {
          return "select project";
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<Project> state,
      ) {
        return GestureDetector(
          onTap: () {
            navigateAndDisplayProject(context, state);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "project",
                    contentPadding: EdgeInsets.all(10.0),
                    isDense: true,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(
                            _project == null ? "select project" : _project.name)
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

  onProjectSelected(
    BuildContext context,
    Project project,
  ) {
    Navigator.of(context).pop();
    setState(() {
      project = project;
    });
  }

  navigateAndDisplayProject(
      BuildContext context, FormFieldState<Project> state) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProjectsScreen(
              title: "select project",
              isSelectOnClick: true,
              showTabs: false,
            )));

    if (result is Project) {
      setState(() {
        state.didChange(result);
        _project = result;
      });
    }
  }

  void finishedAddingReceipt(Receipt receipt) {
    setState(() {
      _isLoading = false;
    });
    if (receipt != null) Navigator.of(context).pop(receipt);
  }

  @override
  void dispose() {
    outReceiptsListener.cancel();
    super.dispose();
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
                    _createReceipt();
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

  void _createReceipt() {
    setState(() {
      _isLoading = true;
    });
    receiptBloc.createWithPicture(createReceiptObject(), _image);
  }
}
