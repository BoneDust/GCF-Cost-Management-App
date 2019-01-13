import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/repository/repository.dart';
import 'package:cm_mobile/repository/repository_implementation.dart';
import 'dart:async';

class GenericBloc<T> extends BlocBase{
  Repository<T> repository = RepositoryImplementation<T>();

  StreamController<List<T>> _getItemsController = StreamController<List<T>>.broadcast();
  Stream<List<T>> get outItems => _getItemsController.stream.asBroadcastStream();
  Sink<List<T>> get inItems => _getItemsController.sink;

  StreamController<T> _getItemController = StreamController<T>();
  Stream<T> get outItem => _getItemController.stream.asBroadcastStream();
  Sink<T> get inItem => _getItemController.sink;

  StreamController<T> _createItemController = StreamController<T>();
  Stream<T> get outCreateItem => _createItemController.stream.asBroadcastStream();
  Sink<T> get inCreateItem => _createItemController.sink;

  StreamController<T> _updatedItemController = StreamController<T>();
  Stream<T> get outUpdatedItem => _updatedItemController.stream.asBroadcastStream();
  Sink<T> get inUpdatedItem => _updatedItemController.sink;

  StreamController<bool> _deletedItemController = StreamController<bool>();
  Stream<bool> get outDeletedItem => _deletedItemController.stream;
  Sink<bool> get inDeletedItem => _deletedItemController.sink;

  StreamController<List<T>> _outItemsByProjectController = StreamController<List<T>>();
  Stream<List<T>>get outItemsByProject => _outItemsByProjectController.stream;
  Sink<List<T>> get _inItemsByProject => _outItemsByProjectController.sink;

  @override
  void dispose() {
    _getItemsController.close();
    _createItemController.close();
    _updatedItemController.close();
    _deletedItemController.close();
    _getItemController.close();
    _outItemsByProjectController.close();
  }

  void getAll() {
    repository.getAll().then((item) {
      inItems.add(item);
    }).catchError((error) => _getItemsController.addError(error));
  }

  void get(int id) {
    repository.getById(id).then((item) {
      inItem.add(item);
    }).catchError((error) =>  _getItemController.addError(error));
  }

  void create(T item) {
    repository.create(item).then((item) {
      inCreateItem.add(item);
    }).catchError((error) => _createItemController.addError(error));
  }

  void update(T item, int id) {
    repository.update(item, id).then((item) {
      inUpdatedItem.add(item);
    }).catchError((error) =>  _updatedItemController.addError(error));
  }

  void delete(int id) {
    repository.delete(id).then((item) {
      inDeletedItem.add(item);
    }).catchError((error) => _deletedItemController.addError(error));
  }

  void getByProject(int projectId) {
    repository.getByProjectId(projectId).then((item) {
      _inItemsByProject.add(item);
    }).catchError((error) =>  _getItemsController.addError(error));
  }
}