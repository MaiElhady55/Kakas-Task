import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kakas_task/core/network/remote/dio_helper.dart';
import 'package:kakas_task/core/network/remote/endpoints.dart';
import 'package:kakas_task/features/auth/data/models/login_model.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  LoginModel? loginModel;

  Future<void> loginUser({
    required String userName,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> data = {
      "username": userName,
      "password": password
    };
    try {
      Response response =
          await DioHelper.postData(endPoint: ApiConstance.login, data: data);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(response.data);
        _isLoading = false;
        print('Data  ${response.data}');
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error ${e.toString()}');
    }
  }

  void changevisibilityPassword() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
