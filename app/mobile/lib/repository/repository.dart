abstract class Repository<T> {
  Future<T> getById(int id);
  Future<List<T>> getAll([String filter]);
  Future<T> create(T item);
  Future<bool> delete(int id);
  Future<T> update(T item, int id);
  Future<List<T>> getByProjectId(int projectId);
}