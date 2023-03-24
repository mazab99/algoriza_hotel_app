import 'package:algoriza_hotel_app/data/di/di.dart';
import 'package:algoriza_hotel_app/data/source/network/api_result_handler.dart';

import '../../source/network/endpoints.dart';
import '../../source/network/my_dio.dart';

class FacilitiesRepository {
  Future<ApiResults> getFacilitiesData() async {
    return await sl<MyDio>().getData(endPoint: facilitiesEP);
  }
}
