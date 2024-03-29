import 'dart:developer';
import 'dart:io';

import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/profile_provider.dart';
import 'package:eamar_user_app/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/body/review_body.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/data/model/response/response_model.dart';
import 'package:eamar_user_app/data/model/response/review_model.dart';
import 'package:eamar_user_app/data/repository/product_details_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';
import 'package:eamar_user_app/provider/banner_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductDetailsRepo? productDetailsRepo;
  ProductDetailsProvider({required this.productDetailsRepo});


bool _slugLoading=true;
bool get slugLoading => _slugLoading;





  List<ReviewModel>? _reviewList;
  int? _imageSliderIndex;
  bool _wish = false;
  int _quantity = 0;
  int? _variantIndex;
  List<int>? _variationIndex;
  int _rating = 0;
    double _ratingValue = 0.0;

  bool _isLoading = false;
  int? _orderCount;
  int? _wishCount;
  String? _sharableLink;
  String? _errorText;
  bool _hasConnection = true;

  List<ReviewModel>? get reviewList => _reviewList;
  int? get imageSliderIndex => _imageSliderIndex;
  bool get isWished => _wish;
  int get quantity => _quantity;
  int? get variantIndex => _variantIndex;
  List<int>? get variationIndex => _variationIndex;
  int get rating => _rating;
    double get ratingValue => _ratingValue;

  bool get isLoading => _isLoading;
  int? get orderCount => _orderCount;
  int? get wishCount => _wishCount;
  String? get sharableLink => _sharableLink;
  String? get errorText => _errorText;
  bool get hasConnection => _hasConnection;

  Product?   myProdutt;
  // String rating;

Future<void> initProductFromSlug(String? slug, BuildContext context) async {
    _slugLoading = true;
     _hasConnection = true;
    _variantIndex = 0;
    ;
  // notifyListeners();
     ApiResponse reviewResponse = await productDetailsRepo!.getProductDetails(
        slug.toString()
        
        
        );



    if (reviewResponse.response != null && reviewResponse.response!.statusCode == 200) {

myProdutt = Product.fromJson(reviewResponse.response!.data);
removePrevReview();

await initProduct(myProdutt!, context);



    Provider.of<ProductProvider>(context, listen: false).removePrevRelatedProduct();
      Provider.of<ProductProvider>(context, listen: false).initRelatedProductList( 
        myProdutt!.id.toString()
        , context);
      Provider.of<ProductDetailsProvider>(context, listen: false).getCount( myProdutt!.id.toString(), context);
      // Provider.of<ProductDetailsProvider>(context, listen: false).getSharableLink(
      //   myProdutt.id.toString(), context);
      if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      
        Provider.of<WishListProvider>(context, listen: false).checkWishList(
         myProdutt!.id.toString(), context);
      }
      Provider.of<ProductProvider>(context, listen: false).initSellerProductList(
        
           myProdutt!.userId.toString(), 1, context);
















          _slugLoading = false;

    }

 else {
      ApiChecker.checkApi(context, reviewResponse);
      if(reviewResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
            _slugLoading = false;

      }
    }
      _slugLoading = false;
    notifyListeners();

}
  Future<void> initProduct(Product? product, BuildContext context) async {
    _hasConnection = true;
    _variantIndex = 0;
    ;


    ApiResponse reviewResponse = await productDetailsRepo!.getReviews(
      product!.id.toString());
    if (reviewResponse.response != null && reviewResponse.response!.statusCode == 200) {
        Provider.of<BannerProvider>(context,listen: false).
        getProductDetails(context, 
        
        product.slug.toString()
        
        
        );
      _reviewList = [];
      reviewResponse.response!.data.forEach((reviewModel) => _reviewList!.add(ReviewModel.fromJson(reviewModel)));
      _imageSliderIndex = 0;
      _quantity = 1;
    }
    else if (reviewResponse.response != null) {
        Provider.of<BannerProvider>(context,listen: false).getProductDetails(context, 
        
        product.slug.toString()
        
        
        );
      _reviewList = [];
      reviewResponse.response!.data.forEach((reviewModel) => _reviewList!.add(ReviewModel.fromJson(reviewModel)));
      _imageSliderIndex = 0;
      _quantity = 1;
    }
    
     else {
      ApiChecker.checkApi(context, reviewResponse);
      if(reviewResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
  }
_initRating(Product product)
{
 String ratting = product != null &&
     product.rating != null &&
    product.rating!.length != 0?
   product.rating![0].average.toString() : "0";

   _ratingValue=double.parse(ratting);
}
  void initData(Product product) {
    _variantIndex = 0;
    _quantity = 1;
    _variationIndex = [];
    product.choiceOptions!.forEach((element) => _variationIndex!.add(0));
  }

  void removePrevReview() {
    _reviewList = null;
    _sharableLink = null;
  }

  void getCount(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsRepo!.getCount(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderCount = apiResponse.response!.data['order_count'];
      _wishCount = apiResponse.response!.data['wishlist_count'];
    } 
  else    if (apiResponse.response != null ) {
      _orderCount = apiResponse.response!.data['order_count'];
      _wishCount = apiResponse.response!.data['wishlist_count'];
    } 
    
    
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void getSharableLink(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsRepo!.getSharableLink(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _sharableLink = apiResponse.response!.data;
    }
   else  if (apiResponse.response != null ) {
      _sharableLink = apiResponse.response!.data;
    }
    
     else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  void setErrorText(String? error) {
    _errorText = error;
    notifyListeners();
  }

  void removeData() {
    _errorText = null;
    _rating = 0;
    notifyListeners();
  }

  void setImageSliderSelectedIndex(int selectedIndex) {
    _imageSliderIndex = selectedIndex;
    notifyListeners();
  }

  void changeWish() {
    _wish = !_wish;
    notifyListeners();
  }

  void setQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  void setCartVariantIndex(int index) {
    _variantIndex = index;
    _quantity = 1;
    notifyListeners();
  }

  void setCartVariationIndex(int index, int i) {
    _variationIndex![index] = i;
    _quantity = 1;
    notifyListeners();
  }

  void setRating(int rate) {
    _rating = rate;
    notifyListeners();
  }

  Future<ResponseModel> submitReview(ReviewBody reviewBody, List<File> files, String token) async {
    _isLoading = true;
    notifyListeners();

    http.StreamedResponse response = await productDetailsRepo!.submitReview(reviewBody, files, token);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      _rating = 0;
      responseModel = ResponseModel('Review submitted successfully', true);
      _errorText = null;
      notifyListeners();
    } else {
      print('${response.statusCode} ${response.reasonPhrase}');
      responseModel = ResponseModel('${response.statusCode} ${response.reasonPhrase}', false);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
