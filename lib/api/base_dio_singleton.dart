import 'package:dio/dio.dart';
import 'package:navigator_new/api/api_response.dart';

class BaseDio {
  static final BaseDio _singleton = BaseDio._internal();

  factory BaseDio() {
    return _singleton;
  }

  BaseDio._internal();

  Dio dio = Dio();

  Future<APIResponse> getRandomUserList() async {
    Response response = await BaseDio().dio.get('https://randomuser.me/api/?page=3&results=10');
    APIResponse value = APIResponse.fromJson(response.data);
    return Future.value(value);
  }
}
