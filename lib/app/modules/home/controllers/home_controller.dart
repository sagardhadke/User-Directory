import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/models/usersModels.dart';

class HomeController extends GetxController {
  final dio = Dio();
  RxBool isUserLoading = false.obs;

  List<UsersModel> userModel = [];
  @override
  void onInit() {
    super.onInit();
    userApi();
  }

  Future<void> userApi() async {
    try {
      isUserLoading.value = true;
      final userAPiRes =
          await dio.get("https://jsonplaceholder.typicode.com/users");
      if (userAPiRes.statusCode == 200) {
        print("User APi Res ${userAPiRes.data}");
        userModel = userAPiRes.data != null
            ? (userAPiRes.data as List)
                .map((e) => UsersModel.fromJson(e))
                .toList()
            : [];
      } else {
        print("Error ${userAPiRes.statusCode}");
      }
    } catch (e) {
      print("Users Api Error $e");
    } finally {
      isUserLoading.value = false;
    }
  }
}
