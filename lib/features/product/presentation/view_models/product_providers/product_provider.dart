import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kakas_task/core/constance/constance.dart';
import 'package:kakas_task/core/network/remote/dio_helper.dart';
import 'package:kakas_task/core/network/remote/endpoints.dart';
import 'package:kakas_task/features/product/data/models/product_model.dart';
import 'dart:io';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  ProductModel? productModel;

  final List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  Future<void> addProduct(
      {required String title,
      required String image,
      required int price}) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> data = {
      "title": title,
      "price": price,
      "image": image
    };
    try {
      Response response = await DioHelper.postData(
          endPoint: ApiConstance.addProducts, data: data, token: myToken);
      if (response.statusCode == 200) {
        productModel = ProductModel.fromJson(response.data);

        _isSuccess = true;
        _isLoading = false;
        getAllProducts(null);
        print('Data  ${response.data}');
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _isSuccess = false;
      notifyListeners();
      print('Error ${e.toString()}');
    }
  }

  Future<void> getAllProducts(String? title) async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await DioHelper()
          .getData(endPoint: ApiConstance.products(title), token: myToken);
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        _productList.clear();
        for (var productData in responseData) {
          ProductModel productModel = ProductModel.fromJson(productData);
          _productList.add(productModel);
        }
        print('*******_productList ${_productList[0].image}');
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error ${e.toString()}');
    }
  }

  Future<void> deleteProduct({required int id}) async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await DioHelper.deleteData(
          endPoint: ApiConstance.deleteProduct(id: id), token: myToken);
      if (response.statusCode == 200) {
        productModel = ProductModel.fromJson(response.data);
        _isSuccess = true;
        _isLoading = false;
        getAllProducts(null);
        print('Data  ${response.data}');
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _isSuccess = false;
      notifyListeners();
      print('Error ${e.toString()}');
    }
  }

  Future<void> editProduct(
      {required String title,
      required String image,
      required int id,
      required int price}) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> data = {
      "title": title,
      "price": price,
      "image": image
    };
    try {
      Response response = await DioHelper.putData(
          endPoint: ApiConstance.editProduct(id: id),
          data: data,
          token: myToken);
      if (response.statusCode == 200) {
        productModel = ProductModel.fromJson(response.data);

        _isSuccess = true;
        _isLoading = false;
        getAllProducts(null);
        print('Data  ${response.data}');
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _isSuccess = false;
      notifyListeners();
      print('Error ${e.toString()}');
    }
  }

  Future<String> uploadImage(File file) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: "upload.jpg")
    });
    try {
      Response response = await DioHelper.postData(
          endPoint: ApiConstance.uploadImage, data: formData, token: myToken);
      if (response.statusCode == 200) {
        print('*******RESPONSE ******* ${response.data}');
        return response.data['url'];
      }
    } catch (e) {
      print('******EEEEERRROE ${e.toString()}');
    }
    return '';
  }
}
