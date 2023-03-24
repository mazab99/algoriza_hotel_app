import 'package:algoriza_hotel_app/data/di/di.dart';
import 'package:algoriza_hotel_app/data/source/network/api_result_handler.dart';

import '../../source/network/endpoints.dart';
import '../../source/network/my_dio.dart';

class RegisterRepository {
  Future<ApiResults> createRegisterData(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    return await sl<MyDio>().postData(endPoint: registerEP, data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
  }
}
