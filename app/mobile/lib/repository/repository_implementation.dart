import 'package:cm_mobile/repository/repository.dart';
import 'package:cm_mobile/service/model_api_service.dart';

class RepositoryImplementation<T> implements Repository<T> {
  ApiService<T> apiService = ApiService<T>();

  @override
  Future<T> create(T item) {
    return apiService.create(item);
  }

  @override
  Future<bool> delete(int id) {
    return apiService.delete(id);
  }

  @override
  Future<List<T>> getAll([String filter]) {
    return apiService.getAll(filter);
  }

  @override
  Future<T> getById(int id) {
    return apiService.getById(id);
  }

  @override
  Future<T> update(T item, int id) {
    return apiService.update(item, id);
  }

  @override
  Future<List<T>> getByProjectId(int projectId) {
    return apiService
        .getByProject(projectId);
  }
}
