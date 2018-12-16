import 'dart:async';

import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class ActivityBloc extends BlocBase {
  Stream<List<Activity>> _queryResults = Stream.empty();

  Stream<List<Activity>> get results => _queryResults;

  final ApiService _apiService;

  ReplaySubject<String> _query = ReplaySubject<String>();

  Sink<String> get query => _query;

  ActivityBloc(this._apiService) {
    _queryResults = _query
        .distinct()
        .asyncMap(_apiService.queryActivities)
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
  }
}
