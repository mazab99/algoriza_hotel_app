import 'package:algoriza_hotel_app/data/di/di.dart';
import 'package:algoriza_hotel_app/data/source/network/api_result_handler.dart';

import '../../source/network/endpoints.dart';
import '../../source/network/my_dio.dart';

class HotelsRepository {
  Future<ApiResults> getHotelsData(
    int count,
    int page,
  ) async {
    return await sl<MyDio>().getData(endPoint: hotelsEP, queryParameters: {
      'count': count,
      'page': page,
    });
  }
}
