import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

class ReceiptBloc extends BlocBase {
  Stream<List<Receipt>> _queryResults = Stream.empty();


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
    _query.close();
  }
}