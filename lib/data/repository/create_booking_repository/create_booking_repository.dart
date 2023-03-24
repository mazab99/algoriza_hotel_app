import 'package:algoriza_hotel_app/data/di/di.dart';
import 'package:algoriza_hotel_app/data/source/network/api_result_handler.dart';

import '../../source/network/endpoints.dart';
import '../../source/network/my_dio.dart';

class CreateBookingRepository {
  Future<ApiResults> createBooking(
    int hotelID,
  ) async {
    return await sl<MyDio>().postData(endPoint: createBookingEP, data: {
      'hotel_id': hotelID,
    });
  }
}
