import 'package:navigator_new/api/api_response.dart';
import 'package:navigator_new/api/base_dio_singleton.dart';
import 'package:rxdart/rxdart.dart';

class MyBloc {
  MyBloc() {
    listFn(APIResponse());
  }

  final listBS = BehaviorSubject<APIResponse>();

  Function(APIResponse) get listFn => listBS.sink.add;

  Future<APIResponse> apiCall() async {
    APIResponse value = await BaseDio().getRandomUserList();
    listFn(value);
    return Future.value(listBS.value);
  }
}
