
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/model_api_service.dart';
import 'package:cm_mobile/util/StringUtil.dart';
import 'package:test/test.dart';

void main() {
  test('my first unit test', () async {

    ApiService<User> apiService = ApiService<User>();
    var list = await apiService.getAll();
    print(list);

    var answer = 42;
    expect(answer, 42);
  });

  test('my first  test', () async {

    String answer = StringUtil.createInitials("M");
    expect(answer, "fu");
  });
}