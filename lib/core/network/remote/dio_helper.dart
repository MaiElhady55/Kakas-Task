import 'package:dio/dio.dart';
import 'package:kakas_task/core/network/remote/endpoints.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstance.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData(
      {required String endPoint, required dynamic data, String? token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response = await dio.post(
      endPoint,
      data: data,
    );
    return response;
  }

  Future<Response> getData({
    required String endPoint,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response = await dio.get(endPoint);
    return response;
  }

  static Future<Response> putData(
      {required String endPoint,
      required Map<String, dynamic> data,
      String? token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response = await dio.put(endPoint, data: data);
    return response;
  }

  static Future<Response> deleteData(
      {required String endPoint, String? token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response = await dio.delete(
      endPoint,
    );
    return response;
  }
}
