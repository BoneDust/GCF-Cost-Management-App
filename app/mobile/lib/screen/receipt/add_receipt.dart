import 'dart:io';
import 'dart:ui';

import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/receipt_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/image_viewer.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReceiptScreen extends StatefulWidget {
  Project project;

  @override
  State<StatefulWidget> createState() {
    return _AddReceiptState();
  }
}

class _AddReceiptState extends State<AddReceiptScreen> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();
  TextEditingController supplierController = TextEditingController();

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
        )
    ),
  );
  File _image;

  bool _isLoading = false;

  int projectId;

  ReceiptBloc receiptBloc;

  @override
  void initState() {
    receiptBloc = ReceiptBloc(ApiService());
    receiptBloc.outAddedReceipt
        .listen((receipt) => finishedAddingReceipt(receipt));

    super.initState();
  }

  get getReceipt => Receipt(
    description: descriptionController.text,
    totalCost: 12,
    supplier: supplierController.text,
    projectId: projectId,
    purchaseDate: DateTime.now(),

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
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
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
                  title: _buildRoundButton(Icons.add_a_photo, "take receipt picture"),
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
    );
  }

  Widget _buildRoundButton(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              getImage();
              setState(() {});
            }),
        Text(title)
      ],
    );
  }

  Widget _loadingIndicator() {
    return Stack(
      children: <Widget>[
        Container(
          child:  BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child:  Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Center(
          child: CircularProgressIndicator(backgroundColor: Colors.green,),
        ),
      ],
    );
  }

  Widget _receiptFields() {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "amount",
                  prefix: Text("R")
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "supplier"),
            ),
            TextFormField(
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
                    color: Colors.blueGrey,
                    child: Text("submit", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      receiptBloc.addReceipt(Receipt());
                    })
              ],
            )
          ],
      ),
    );
  }

  void finishedAddingReceipt(Receipt receipt) {
    setState(() {
      _isLoading = false;
    });
    if (receipt != null) Navigator.of(context).pop();
  }

}

