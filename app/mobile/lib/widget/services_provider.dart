import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';

class ServicesContainer extends StatefulWidget {
  final Widget child;

  ServicesContainer({@required this.child});

  static ServicesContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  ServicesContainerState createState() => new ServicesContainerState();
}

class ServicesContainerState extends State<ServicesContainer> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final ServicesContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
