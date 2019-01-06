import 'dart:async';

import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptBloc extends BlocBase {
  Stream<List<Receipt>> _queryResults = Stream.empty();

  StreamController<Receipt> _addedReceiptController = StreamController<Receipt>();

  Stream<Receipt> get outAddedReceipt => _addedReceiptController.stream;
  Sink<Receipt> get inAddedReceipt => _addedReceiptController.sink;


  Stream<List<Receipt>> get results => _queryResults;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  ReceiptBloc(this._apiService) {
    _queryResults = _query
        .distinct()
        .asyncMap(_apiService.queryReceipts)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _addedReceiptController.close();
    _query.close();
  }

  void addReceipt(Receipt receipt) {
    _apiService.addReceipt(receipt).then((project) {
      // ignore: argument_type_not_assignable
      inAddedReceipt.add(receipt);
    });
  }
}