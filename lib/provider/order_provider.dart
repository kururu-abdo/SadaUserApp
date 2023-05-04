import 'package:eamar_user_app/data/model/body/order_place_model.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/base/error_response.dart';
import 'package:eamar_user_app/data/model/response/cart_model.dart';
import 'package:eamar_user_app/data/model/response/order_details.dart';
import 'package:eamar_user_app/data/model/response/order_model.dart';
import 'package:eamar_user_app/data/model/response/refund_info_model.dart';
import 'package:eamar_user_app/data/model/response/refund_result_model.dart';
import 'package:eamar_user_app/data/model/response/shipping_method_model.dart';
import 'package:eamar_user_app/data/repository/order_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  final OrderRepo orderRepo;
  OrderProvider({@required this.orderRepo});

  List<OrderModel> _pendingList;
  List<OrderModel> _deliveredList;
  List<OrderModel> _canceledList;
  int _addressIndex;
  int _billingAddressIndex;
  int get billingAddressIndex => _billingAddressIndex;
  int _shippingIndex;
  bool _isLoading = false;
  bool _isRefund = false;
  bool get isRefund => _isRefund;
  List<ShippingMethodModel> _shippingList;
  int _paymentMethodIndex = 0;

  List<OrderModel> get pendingList => _pendingList != null ? _pendingList.reversed.toList() : _pendingList;
  List<OrderModel> get deliveredList => _deliveredList != null ? _deliveredList.reversed.toList() : _deliveredList;
  List<OrderModel> get canceledList => _canceledList != null ? _canceledList.reversed.toList() : _canceledList;
  int get addressIndex => _addressIndex;
  int get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  List<ShippingMethodModel> get shippingList => _shippingList;
  int get paymentMethodIndex => _paymentMethodIndex;
  XFile _imageFile;
  XFile get imageFile => _imageFile;
  List <XFile>_refundImage = [];
  List<XFile> get refundImage => _refundImage;

  RefundInfoModel _refundInfoModel;
  RefundInfoModel get refundInfoModel => _refundInfoModel;
  RefundResultModel _refundResultModel;
  RefundResultModel get refundResultModel => _refundResultModel;




  Future<void> initOrderList(BuildContext context) async {
    ApiResponse apiResponse = await orderRepo.getOrderList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _pendingList = [];
      _deliveredList = [];
      _canceledList = [];
      apiResponse.response.data.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == AppConstants.PENDING || orderModel.orderStatus == AppConstants.CONFIRMED || orderModel.orderStatus ==AppConstants.OUT_FOR_DELIVERY
            || orderModel.orderStatus == AppConstants.PROCESSING || orderModel.orderStatus == AppConstants.PROCESSED) {
          _pendingList.add(orderModel);
        } else if (orderModel.orderStatus == AppConstants.DELIVERED) {
          _deliveredList.add(orderModel);
        } else if (orderModel.orderStatus == AppConstants.CANCELLED || orderModel.orderStatus == AppConstants.FAILED
            || orderModel.orderStatus == AppConstants.RETURNED) {
          _canceledList.add(orderModel);
        }
      });
    }
    else  if (apiResponse.response != null ) {
      _pendingList = [];
      _deliveredList = [];
      _canceledList = [];
      apiResponse.response.data.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == AppConstants.PENDING || orderModel.orderStatus == AppConstants.CONFIRMED || orderModel.orderStatus ==AppConstants.OUT_FOR_DELIVERY
            || orderModel.orderStatus == AppConstants.PROCESSING || orderModel.orderStatus == AppConstants.PROCESSED) {
          _pendingList.add(orderModel);
        } else if (orderModel.orderStatus == AppConstants.DELIVERED) {
          _deliveredList.add(orderModel);
        } else if (orderModel.orderStatus == AppConstants.CANCELLED || orderModel.orderStatus == AppConstants.FAILED
            || orderModel.orderStatus == AppConstants.RETURNED) {
          _canceledList.add(orderModel);
        }
      });
    }
     else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  List<OrderDetailsModel> _orderDetails;
  List<OrderDetailsModel> get orderDetails => _orderDetails;

  void getOrderDetails(String orderID, BuildContext context, String languageCode) async {
    _orderDetails = null;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.getOrderDetails(orderID, languageCode);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _orderDetails = [];
      apiResponse.response.data.forEach((order) => _orderDetails.add(OrderDetailsModel.fromJson(order)));
    } 
    else  if (apiResponse.response != null ) {
      _orderDetails = [];
      apiResponse.response.data.forEach((order) => _orderDetails.add(OrderDetailsModel.fromJson(order)));
    } 
    
    
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> placeOrder(OrderPlaceModel orderPlaceModel, Function callback, List<CartModel> cartList, String addressID, String couponCode, String billingAddressId, String orderNote) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.placeOrder(addressID, couponCode, billingAddressId, orderNote);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _addressIndex = null;
      _billingAddressIndex = null;
      String message = apiResponse.response.data.toString();
      callback(true, message, '', cartList);

await FirebaseAnalytics.instance
.logAddPaymentInfo(
  currency: 'SAR' ,
  paymentType: orderPlaceModel.paymentMethod
);

// await FirebaseAnalytics.instance.logEvent(
//     name: "store",
//     parameters: {
//         "store": orderPlaceModel.,
//         "full_text": text,
//     },
// );
// await FirebaseAnalytics.instance
// .logEvent(name: 'Buy' ,

// parameters: {
//    "value": 10.0,
//     "currency": 'SAR',
//     "items":    orderPlaceModel.cart.map((e) => 

//       {  "itemName": e.name,
//         "itemId": e.id.toString(),
//         "price": e.price
//       }
    
//     ).toList()
// }
// );
// await FirebaseAnalytics.instance
//   .logPurchase(
//     // value: 10.0,
//     currency: 'SAR',
//     items:
//     orderPlaceModel.cart.map((e) => 

//       AnalyticsEventItem(
//         itemName: e.name,
//         itemId: e.id.toString(),
//         price: e.price
//       )
    
//     ).toList() ,
    
  
//     //  [
//     //   AnalyticsEventItem(
//     //     itemName: 'Socks',
//     //     itemId: 'xjw73ndnw',
//     //     price: '10.0'
//     //   ),
//     // ],
//     coupon: couponCode.toString(),
//     callOptions: AnalyticsCallOptions(global: true)
//   );



await FirebaseAnalytics.instance.logPurchase(
    transactionId: DateTime.now().microsecondsSinceEpoch.toString(),
    affiliation: "Eamar Store",
    currency: 'SAR',
    // value: 15.98,
    // shipping: orderPlaceModel.paymentMethod.,
    // tax: 1.66,
    // coupon: "SUMMER_FUN",
    items:  orderPlaceModel.cart.map((e) => 

      AnalyticsEventItem(
        itemName: e.name,
        itemId: e.id.toString(),
        price: e.price
      )
    
    ).toList() ,
);

// const data = {
//              "transaction_id": 'T)ID',
//              "value": 1.00,
//              "currency": 'USD',
//              "tax": 0,
//              "shipping": 0,
//              "coupon": '',
//              "items": [{
//                      "item_id": 'I_ID',
//                      "item_name": 'I_NAME',
//                      "item_list_name": 'IL_NAME',
//                      "item_list_id": 'IL_ID',
//                      "item_brand": 'I_B',
//                      "item_category": 'I_C',
//                      "item_variant": 'I_V',
//                      "quantity": 1,
//                      "price": 1,
//                      }]
//                };
                    
// await FirebaseAnalytics.instance.logEvent(name: 'purchase', parameters:   data);

    }
    else   if (apiResponse.response != null ) {
      _addressIndex = null;
      _billingAddressIndex = null;
      String message = apiResponse.response.data.toString();
      callback(true, message, '', cartList);
    }
    
     else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage, '-1', cartList);
    }
    notifyListeners();
  }

  void stopLoader() {
    _isLoading = false;
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }
  void setBillingAddressIndex(int index) {
    _billingAddressIndex = index;
    notifyListeners();
  }

  Future<void> initShippingList(BuildContext context, int sellerID) async {
    _paymentMethodIndex = 0;
    _shippingIndex = null;
    _addressIndex = null;
    ApiResponse apiResponse = await orderRepo.getShippingMethod(sellerID);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _shippingList = [];
      apiResponse.response.data.forEach((shippingMethod) => _shippingList.add(ShippingMethodModel.fromJson(shippingMethod)));
    } 
   else  if (apiResponse.response != null ) {
      _shippingList = [];
      apiResponse.response.data.forEach((shippingMethod) => _shippingList.add(ShippingMethodModel.fromJson(shippingMethod)));
    }  
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void shippingAddressNull(){
    _addressIndex = null;
    notifyListeners();
  }

  void billingAddressNull(){
    _billingAddressIndex = null;
    notifyListeners();
  }

  void setSelectedShippingAddress(int index) {
    _shippingIndex = index;
    notifyListeners();
  }
  void setSelectedBillingAddress(int index) {
    _billingAddressIndex = index;
    notifyListeners();
  }

  OrderModel _trackingModel;
  OrderModel get trackingModel => _trackingModel;

  Future<void> initTrackingInfo(String orderID, OrderModel orderModel, bool fromDetails, BuildContext context) async {
    if(fromDetails) {
      _orderDetails = null;
    }
    if(orderModel == null) {
      _trackingModel = null;
      notifyListeners();
      ApiResponse apiResponse = await orderRepo.getTrackingInfo(orderID);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _trackingModel = OrderModel.fromJson(apiResponse.response.data);
      }
      
      else    if (apiResponse.response != null ) {
        _trackingModel = OrderModel.fromJson(apiResponse.response.data);
      }
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      _trackingModel = orderModel;
    }
  }

  void setPaymentMethod(int index) {
    _paymentMethodIndex = index;
    notifyListeners();
  }
  void pickImage(bool isRemove) async {
    if(isRemove) {
      _imageFile = null;
      _refundImage = [];
    }else {
      _imageFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
      if (_imageFile != null) {
        _refundImage.add(_imageFile);

      }
    }
    notifyListeners();
  }
  void removeImage(int index){
    refundImage.removeAt(index);
    notifyListeners();
  }

  Future<http.StreamedResponse> refundRequest(BuildContext context, int orderDetailsId, double amount, String refundReason, String token) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await orderRepo.refundRequest(orderDetailsId, amount, refundReason,refundImage, token);
    if (response.statusCode == 200) {
      getRefundReqInfo(context, orderDetailsId);
      _imageFile = null;
      _refundImage = [];
      _isLoading = false;
      print('=== refund requested');
    } else {
      _isLoading = false;
      print('===${response.statusCode}');
    }
    _imageFile = null;
    _refundImage = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }
  Future<ApiResponse> getRefundReqInfo(BuildContext context, int orderDetailId) async {
    _isRefund = true;
    ApiResponse apiResponse = await orderRepo.getRefundInfo(orderDetailId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _refundInfoModel = RefundInfoModel.fromJson(apiResponse.response.data);
      _isRefund = false;
    } else if(apiResponse.response.statusCode == 202){
      _isRefund = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:Colors.red,
        content: Text('${apiResponse.response.data['message']}'),
      ));
    }
    else {
      _isRefund = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getRefundResult(BuildContext context, int orderDetailId) async {
    _isLoading =true;

    ApiResponse apiResponse = await orderRepo.getRefundResult(orderDetailId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;
      _refundResultModel = RefundResultModel.fromJson(apiResponse.response.data);
    }
   else if (apiResponse.response != null ) {
      _isLoading = false;
      _refundResultModel = RefundResultModel.fromJson(apiResponse.response.data);
    }
    
     else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> cancelOrder(BuildContext context, int orderId) async {
    _isLoading = true;
    ApiResponse apiResponse = await orderRepo.cancelOrder(orderId);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _isLoading = false;

    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

}
