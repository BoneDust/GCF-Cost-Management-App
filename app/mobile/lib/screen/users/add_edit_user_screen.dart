import 'dart:io';
import 'dart:ui';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/profile_image_viewer.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditUserScreen extends StatefulWidget {
  final bool isEditing;
  final User user;

  const AddEditUserScreen({Key key, this.isEditing = false, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddEditUserScreenState();
  }
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  bool _isLoading = false;
  GenericBloc<User> userBlocs;

  bool _obscureText = true;

  Privilege _privilege;

  String _password;

  Widget previewImage;
  File _image;

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    userBlocs = GenericBloc<User>();

    if (widget.isEditing) {

      userBlocs.outUpdatedItem
          .listen((user) => onUserReceived(user)).onError(handleError);

      fillFormsWithUserData();
    } else {

      userBlocs.outCreateItem
          .listen((user) => onUserReceived(user)).onError(handleError);
    }


    previewImage =  Container(
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        onPressed: () {
        },
      ),
    );

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
                      onPressed:   widget.isEditing ? updateUser : _createUser
                  )
                ],
                elevation: 5,
                forceElevated: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: Text(widget.isEditing ? "edit user" : "create a user"),
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
        _isLoading ? LoadingIndicator(text: widget.isEditing ? "saving user" : "creating user") : Column()
      ],
    );
  }

  void onUserReceived(User user) {
    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop(user);
  }

  User createUser() => User(
        name: nameController.text,
        privilege: _privilege,
        email: _emailController.text,
        surname: surnameController.text,
        password: _password,
        image: "fdhgdf",
      );

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      previewImage = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileImageViewer(
                        image: _image,
                      )));
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: FileImage(_image), fit: BoxFit.cover)),
        ),
      );
    });
  }

  void _createUser() {
    setState(() {
      _isLoading = true;
    });
    userBlocs.create(createUser());
  }

  void fillFormsWithUserData() {
    _emailController.text = widget.user.email;
    _privilege = widget.user.privilege;
    nameController.text = widget.user.name;
    surnameController.text = widget.user.surname;
  }

  void updateUser() {
    setState(() {
      _isLoading = true;
    });
    User updatedUser = getUpdatedUser();
    userBlocs.update(updatedUser, updatedUser.id);
  }

  User getUpdatedUser() {
    User user = createUser();
    user.id = widget.user.id;
    return user;
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
                    widget.isEditing ? updateUser() : _createUser();
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

  Widget _formFields() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        ListTile(
          leading: CircleAvatar(child: previewImage ,),
          title: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0), labelText: 'name'),
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: surnameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0), labelText: 'surname'),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0), labelText: 'email'),
          ),
        ),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'password',
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  _toggle();
                },
              ),
            ),
            validator: (val) => val.length < 6 ? 'Password too short.' : null,
            onSaved: (val) => _password = val,
            obscureText: _obscureText,
          ),
        ),
        ListTile(
          title:  _dropDownFormField()
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  Widget _dropDownFormField() {
    return FormField<Privilege>(
      validator: (value) {
        if (value == null) {
          return "Select privilege";
        }
      },
      onSaved: (value) {},
      builder: (
        FormFieldState<Privilege> state,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputDecorator(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                labelText: 'foreman',
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Privilege>(
                  isExpanded: true,
                  hint: Text("select foreman"),
                  value: _privilege,
                  onChanged: (Privilege newValue) {
                    state.didChange(newValue);
                    setState(() {
                      _privilege = newValue;
                    });
                  },
                  items: Privilege.values.map((Privilege value) {
                    return DropdownMenuItem<Privilege>(
                        child: Text(PrivilegeType[value]), value: value);
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
}
