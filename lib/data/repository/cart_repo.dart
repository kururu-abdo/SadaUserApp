
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:eamar_user_app/data/datasource/remote/dio/dio_client_no_cache.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:eamar_user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/cart_model.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final DioClientNoCache dioClient;
  final SharedPreferences sharedPreferences;
  CartRepo({@required this.dioClient, @required this.sharedPreferences});


  List<CartModel> getCartList() {
    List<String> carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    List<CartModel> cartList = [];
    carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)) );
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }



  Future<ApiResponse> getCartListData() async {
    try {
      final response = await dioClient.get(AppConstants.GET_CART_DATA_URI);

      log(response.data.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> addToCartListData(CartModel cart, List<ChoiceOptions> choiceOptions, List<int> variationIndexes) async {
    Map<String, dynamic> _choice = Map();
    for(int index=0; index<choiceOptions.length; index++){
      _choice.addAll({choiceOptions[index].name: choiceOptions[index].options[variationIndexes[index]]});
    }
    Map<String, dynamic> _data = {'id': cart.id,
      'variant': cart.variation != null ? cart.variation.type : null,
      'quantity': cart.quantity};
    _data.addAll(_choice);
    if(cart.variant.isNotEmpty) {
      _data.addAll({'color': cart.color});
    }

    try {
      final response = await dioClient.post(
        AppConstants.ADD_TO_CART_URI,
        data: _data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> updateQuantity( int key,int quantity) async {
    log('Body: ${{'_method': 'put', 'key': key, 'quantity': quantity}}');
    try {
      final response = await dioClient.post(AppConstants.UPDATE_CART_QUANTITY_URI,
        data: {'_method': 'put', 'key': key, 'quantity': quantity});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> removeFromCart(int key) async {
    try {
       Options _options;
_options = cacheOptions.copyWith(
  policy: CachePolicy.noCache
).toOptions();
      final response = await dioClient.post(AppConstants.REMOVE_FROM_CART_URI,
          data: {'_method': 'delete', 'key': key} ,
          options: _options
          
          );
          log(response.data.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getShippingMethod(int sellerId, String type) async {
    try {
      final response = await dioClient.get('${AppConstants.GET_SHIPPING_METHOD}/$sellerId/$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addShippingMethod(int id, String cartGroupId) async {
    print('===>${{"id":id, "cart_group_id": cartGroupId}}');
    try {
      final response = await dioClient.post(AppConstants.CHOOSE_SHIPPING_METHOD, data: {"id":id, "cart_group_id": cartGroupId});
     
     log(response.data.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getChosenShippingMethod() async {
    try {
      final response =await dioClient.get(AppConstants.CHOSEN_SHIPPING_METHOD_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSelectedShippingType(int sellerId, String sellerType) async {
    try {
      final response = await dioClient.get('${AppConstants.GET_SELECTED_SHIPPING_TYPE_URI}?seller_id=$sellerId&seller_is=$sellerType');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
