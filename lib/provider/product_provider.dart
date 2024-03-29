import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/data/repository/product_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';
import 'package:eamar_user_app/helper/product_type.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo? productRepo;
  ProductProvider({required this.productRepo});

  // Latest products
  List<Product>? _latestProductList = [];
    List<Product>? discountProducts = [];
      List<Product>? newArrivalsProducts = [];
  List<Product> _lProductList = [];
  List<Product> get lProductList=> _lProductList;
  List<Product> _featuredProductList = [];


  ProductType _productType = ProductType.NEW_ARRIVAL;
  String? _title = 'xyz';

  bool _filterIsLoading = false;
  bool _filterFirstLoading = true;

  bool _isLoading = false;
  bool _isFeaturedLoading = false;
  bool get isFeaturedLoading => _isFeaturedLoading;
  bool _firstFeaturedLoading = true;
  bool _firstLoading = true;
  int? _latestPageSize;
   int? _arrivalPageSize;
  int _lOffset = 1;
  int _sellerOffset = 1;
  int? _lPageSize;
  int? get lPageSize=> _lPageSize;
  int? _featuredPageSize;

  ProductType get productType => _productType;
  String? get title => _title;
  int get lOffset => _lOffset;
  int get sellerOffset => _sellerOffset;

  List<int> _offsetList = [];
   List<int> _newArrivalOffestList = [];
  List<String> _lOffsetList = [];
  List<String> get lOffsetList=>_lOffsetList;
  List<String> _featuredOffsetList = [];

  List<Product>? get latestProductList => _latestProductList;
  List<Product> get featuredProductList => _featuredProductList;

  Product? _recommendedProduct;
  Product? get recommendedProduct=> _recommendedProduct;

  bool get filterIsLoading => _filterIsLoading;
  bool get filterFirstLoading => _filterFirstLoading;
  bool get isLoading => _isLoading;
  bool get firstFeaturedLoading => _firstFeaturedLoading;
  bool get firstLoading => _firstLoading;
  int? get latestPageSize => _latestPageSize;
  int? get arrivalPageSize => _arrivalPageSize;
  int? get featuredPageSize => _featuredPageSize;

 int _filterIndex = 0;

  int get filterIndex => _filterIndex;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }


  //latest product

  Future<void> getLatestProductList(int offset,
   BuildContext context, {bool reload = false}) async {
    if(reload) {
      _offsetList = [];
      _latestProductList = [];
    }
    _lOffset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getLatestProductList(
        context,offset.toString(), productType, title);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _latestProductList!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
       _menuProductList.addAll(_latestProductList!);
       
       
        _latestPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;
      } else if(apiResponse.response != null ){
          _latestProductList!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        _menuProductList.addAll(_latestProductList!);
       
        _latestPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;
      }
      
      
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      if(_filterIsLoading) {
        _filterIsLoading = false;
        notifyListeners();
      }
    }

  }
  
  
  //dicount products

  
  Future<void> getDiscountProducts(int offset,
   BuildContext context, {bool reload = false}) async {
    if(reload) {
      _offsetList = [];
      discountProducts = [];
    }
    _lOffset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getLatestProductList(
        context,offset.toString(), ProductType.DISCOUNTED_PRODUCT,
        
        
         title);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        discountProducts!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
       
        _menuProductList.addAll(discountProducts!);
       
        _latestPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;
      } else if(apiResponse.response != null ){
          discountProducts!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
       menuProductList.addAll(discountProducts!);
       
        _latestPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;
      }
      
      
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      if(_filterIsLoading) {
        _filterIsLoading = false;
        notifyListeners();
      }
    }

  }
  

  //new arriavals

  Future<void> getnewArriavalProducts(int offset,
   BuildContext context, {bool reload = false}) async {
    if(reload) {
      _offsetList = [];
      newArrivalsProducts = [];
    }
    _lOffset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getLatestProductList(
        context,offset.toString(), ProductType.NEW_ARRIVAL,
        
        
         title);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        newArrivalsProducts!.addAll(ProductModel.fromJson(
          apiResponse.response!.data).products!);
        _arrivalPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;
        notifyListeners();
      } else if(apiResponse.response != null ){
          newArrivalsProducts!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        _arrivalPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _filterFirstLoading = false;
        _filterIsLoading = false;

        notifyListeners();
      }
      
      
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      if(_filterIsLoading) {
        _filterIsLoading = false;
        notifyListeners();
      }
    }

  }
    
  
  
  //latest product
  Future<void> getLProductList(String offset, BuildContext context, {bool reload = false}) async {
    if(reload) {
      _lOffsetList = [];
      _lProductList = [];
    }
    if(!_lOffsetList.contains(offset)) {
      _lOffsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getLProductList(offset);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _lProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
      _menuProductList.addAll(_lProductList);
      
        _lPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _firstLoading = false;
        _isLoading = false;
      }    else  if (apiResponse.response != null){
_lProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
  _menuProductList.addAll(_lProductList);
        _lPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _firstLoading = false;
        _isLoading = false;

      }
      
      
      else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      if(_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }

  }


  Future<int?> getLatestOffset(BuildContext context) async {
    ApiResponse apiResponse = await productRepo!.getLatestProductList(context,'1', productType, title);
    return ProductModel.fromJson(apiResponse.response!.data).totalSize;
  }

 void changeTypeOfProduct(ProductType type, String? title){
    _productType = type;
    _title = title;
    _latestProductList = null;
    _latestPageSize = 0;
    _filterFirstLoading = true;
    _filterIsLoading = true;
    notifyListeners();
 }

  void showBottomLoader() {
    _isLoading = true;
    _filterIsLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }

  // Seller products
  List<Product> _sellerAllProductList = [];
  List<Product> _sellerProductList = [];
  int? _sellerPageSize;
  List<Product> get sellerProductList => _sellerProductList;
  int? get sellerPageSize => _sellerPageSize;

  void initSellerProductList(String sellerId, int offset, BuildContext context, {bool reload = false}) async {
    _firstLoading = true;
    if(reload) {
      _offsetList = [];
      _sellerProductList = [];
    }
    _sellerOffset = offset;

 try {
      ApiResponse apiResponse = await productRepo!.
      getSellerProductList(sellerId, offset.toString());
    log(apiResponse.response!.data.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _sellerProductList = [];
      _sellerProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
      _sellerAllProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
      _sellerPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      _firstLoading = false;
      _filterIsLoading = false;
      _filterFirstLoading=false;
      _isLoading = false;
         notifyListeners();

    } else if(apiResponse.response != null ){
       _sellerProductList = [];
      _sellerProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
      _sellerAllProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
      _sellerPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      log('NO PROBLEM WHAT SO EVER');
      _firstLoading = false;
      _filterIsLoading = false;
            _filterFirstLoading=false;

      _isLoading = false;
         notifyListeners();

    }
    
    
    
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
 } catch (e) {
   log(e.toString());
 }

  }

  void filterData(String newText) {
    _sellerProductList.clear();
    if(newText.isNotEmpty) {
      _sellerAllProductList.forEach((product) {
        if (product.name!.toLowerCase().contains(newText.toLowerCase())) {
          _sellerProductList.add(product);
        }
      });
    }else {
      _sellerProductList.clear();
      _sellerProductList.addAll(_sellerAllProductList);
    }
    notifyListeners();
  }

  void clearSellerData() {
    _sellerProductList = [];
    //notifyListeners();
  }

  // Brand and category products
  List<Product> _brandOrCategoryProductList = [];
  List<Product> _searchBrandOrCategoryProductList = [];
   List<Product> _menuProductList =[];
List<Product> _menuFilterProductList =[];
  List<Product> get searchBrandOrCategoryProductList  =>_searchBrandOrCategoryProductList  ;
  List<Product> get menuProductList  =>_menuProductList  ;

  List<Product> get menuFilterProductList  =>_menuFilterProductList  ;

  bool? _hasData;
int? _selectedSubCategory;
int?  get  selectedSubCategory   => _selectedSubCategory;
setSelectedSubCategory(int index){
  _selectedSubCategory=index;
  notifyListeners();
}
  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  bool? get hasData => _hasData;


initMenuProducts(ProductType productType){
  _menuFilterProductList.clear();
  _menuProductList.clear();

if (productType==ProductType.DISCOUNTED_PRODUCT) {
  _menuProductList.addAll(discountProducts!);
  _menuFilterProductList.addAll(_menuProductList);
} 

if(productType==ProductType.LATEST_PRODUCT) {
    _menuProductList.addAll(_lProductList);
  _menuFilterProductList.addAll(_menuProductList);
}

notifyListeners();
  
}


 int? _selectedProductId = 0;

  // List<Product> get brandOrCategoryProductList2 => _selectedProductId==0
  //     ? _brandOrCategoryProductList
  //     : 
  //         _brandOrCategoryProductList.where((prod) {
  //           for (var id in prod.categoryIds) {
  //             id.position
  //           }
  //           return 
          
  //           prod.categoryIds.contains(_selectedProductId);
  //         }

  //         ).toList();




  void sortSearchList(double startingPrice, double endingPrice) {
    _searchBrandOrCategoryProductList = [];
    if(startingPrice > 0 && endingPrice >= startingPrice) {
     
debugPrint("WE ARE HER"+"${startingPrice}  "+"${endingPrice}");
for (var element in _brandOrCategoryProductList) {
  debugPrint("ITEM PRICE  "+element.unitPrice!.toString());
  debugPrint("RESULT"+   ( element.unitPrice! > startingPrice && element.unitPrice! < endingPrice).toString());
}
      _searchBrandOrCategoryProductList.addAll(
        _brandOrCategoryProductList.where((product) =>
     ( product.unitPrice! > startingPrice && product.unitPrice! < endingPrice)
    
     
     ).toList()
      
      
      );
    }else {
      _searchBrandOrCategoryProductList.addAll(_brandOrCategoryProductList);
    }

    if (_filterIndex == 0) {

    } else if (_filterIndex == 1) {
      _searchBrandOrCategoryProductList.sort((a, b) => 
      a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    } else if (_filterIndex == 2) {
      _searchBrandOrCategoryProductList.sort((a, b) => 
      a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      Iterable iterable = _searchBrandOrCategoryProductList.reversed;
      _searchBrandOrCategoryProductList = iterable.toList() as List<Product>;
    } else if (_filterIndex == 3) {
      _searchBrandOrCategoryProductList.sort((a, b) => a.unitPrice!.compareTo(b.unitPrice!));
    } else if (_filterIndex == 4) {
      debugPrint("SORT A TO Z");
      _searchBrandOrCategoryProductList.sort((a, b) => a.unitPrice!.compareTo(b.unitPrice!));
      Iterable iterable = _searchBrandOrCategoryProductList.reversed;
      _searchBrandOrCategoryProductList = iterable.toList() as List<Product>;
    }

    notifyListeners();
  }








  void sortMenuProductList(double startingPrice, double endingPrice, 
  
  
  ) {
    _menuFilterProductList = [];
    if(startingPrice > 0 && endingPrice >= startingPrice) {
     
debugPrint("WE ARE HER"+"${startingPrice}  "+"${endingPrice}");
for (var element in _menuFilterProductList) {
  debugPrint("ITEM PRICE  "+element.unitPrice!.toString());
  debugPrint("RESULT"+   ( element.unitPrice! > startingPrice && element.unitPrice! < endingPrice).toString());
}
      _menuFilterProductList.addAll(
        _menuFilterProductList.where((product) =>
     ( product.unitPrice! > startingPrice && product.unitPrice! < endingPrice)
    
     
     ).toList()
      
      
      );
    }else {
      _menuFilterProductList.addAll(_menuProductList);
    }

    if (_filterIndex == 0) {

    } else if (_filterIndex == 1) {
      _menuFilterProductList.sort((a, b) => 
      a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    } else if (_filterIndex == 2) {
      _menuFilterProductList.sort((a, b) => 
      a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      Iterable iterable = _menuFilterProductList.reversed;
      _menuFilterProductList = iterable.toList() as List<Product>;
    } else if (_filterIndex == 3) {
      _menuFilterProductList.sort((a, b) => a.unitPrice!.compareTo(b.unitPrice!));
    } else if (_filterIndex == 4) {
      debugPrint("SORT A TO Z");
      _menuFilterProductList.sort((a, b) => a.unitPrice!.compareTo(b.unitPrice!));
      Iterable iterable = _menuFilterProductList.reversed;
      _menuFilterProductList = iterable.toList() as List<Product>;
    }

    notifyListeners();
  }










 void changeProductId(int? selectedProductId) {
    _selectedProductId = selectedProductId;
    log(_selectedProductId.toString());
    notifyListeners();
  }
bool isProductLoading=false;
  Future<void> initBrandOrCategoryProductList(bool isBrand, String id, BuildContext context) async {
    _brandOrCategoryProductList.clear();
    _hasData = true;
    isProductLoading=true;
      notifyListeners();

    ApiResponse apiResponse = await productRepo!.getBrandOrCategoryProductList(isBrand, id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
            _brandOrCategoryProductList.clear();
searchBrandOrCategoryProductList.clear();
      List<Product> _products = [];
      apiResponse.response!.data.forEach((product) => 
      
      _products.add(Product.fromJson(product)));
      // _products.addAll(_brandOrCategoryProductList);
      // brandOrCategoryProductList2.clear();

      _brandOrCategoryProductList.addAll(_products.reversed);
            _hasData = _brandOrCategoryProductList.length > 1;

      searchBrandOrCategoryProductList.addAll(_brandOrCategoryProductList);
      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
       isProductLoading=false;

    notifyListeners();
   
   
    } 
    
    
    if (apiResponse.response != null && apiResponse.response!.statusCode == 304) {
   
     searchBrandOrCategoryProductList.clear();
      List<Product> _products = [];
      // _products.addAll(_brandOrCategoryProductList);
      _brandOrCategoryProductList.clear();
      // brandOrCategoryProductList2.clear();
   apiResponse.response!.data.forEach((product) => 
      
      _products.add(Product.fromJson(product)));


      _brandOrCategoryProductList.addAll(_products.reversed);
            searchBrandOrCategoryProductList.addAll(_brandOrCategoryProductList);
 _hasData = _brandOrCategoryProductList.length > 1;
      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
       isProductLoading=false;

    notifyListeners();
   
   
    } 
    
    
    
    
    
    
    
    else {    isProductLoading=false;

    notifyListeners();
      ApiChecker.checkApi(context, apiResponse);
    }
      // notifyListeners();
          isProductLoading=false;

    notifyListeners();
  }


filterBrandAndCategoryProductList(BuildContext context,int? category)async{
  _brandOrCategoryProductList.clear();
  _searchBrandOrCategoryProductList.clear();
    _hasData = true;
    isProductLoading =true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo!.getProductsById(category.toString());
   
   
       log(apiResponse.response!.statusCode.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
   _brandOrCategoryProductList.clear();
      
      List<Product> _products = [];
        _searchBrandOrCategoryProductList.clear();
        apiResponse.response!.data['products'].forEach((product) => 
      _products.add(Product.fromJson(product)));
      _hasData = _brandOrCategoryProductList.length > 1;
      // _products.addAll(_brandOrCategoryProductList);
      // _brandOrCategoryProductList.addAll();
      // _brandOrCategoryProductList2.clear();
// 
      _brandOrCategoryProductList.addAll(_products.reversed);
      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
      _searchBrandOrCategoryProductList.addAll(_brandOrCategoryProductList);
    isProductLoading =false;

          notifyListeners();

    } else  if (apiResponse.response != null){
_brandOrCategoryProductList.clear();
     

      _hasData = _brandOrCategoryProductList.length > 1;
      List<Product> _products = [];
       apiResponse.response!.data['products'].forEach((product) => 
      _products.add(Product.fromJson(product)));
      // _products.addAll(_brandOrCategoryProductList);
      _searchBrandOrCategoryProductList.clear();
      // _brandOrCategoryProductList.addAll();
      // _brandOrCategoryProductList2.clear();
// 
      _brandOrCategoryProductList.addAll(_products.reversed);
            _searchBrandOrCategoryProductList.addAll(_brandOrCategoryProductList);

      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
    isProductLoading =false;

          notifyListeners();
    }
     else {    isProductLoading =false;

      log('HERE IS PROBELM');
      log(apiResponse.error.toString());
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
}


//filter by sub category

filterProductsBySub(){
  try {
    // var _old =  
    _brandOrCategoryProductList.clear();
    // _brandOrCategoryProductList.addAll(  );
  } catch (e) {
  }
}

//
  // Related products
  List<Product>? _relatedProductList;
  List<Product>? get relatedProductList => _relatedProductList;

  void initRelatedProductList(String id, BuildContext context) async {
    ApiResponse apiResponse = await productRepo!.getRelatedProductList(id);
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200  ||apiResponse.response!.statusCode == 200  )) {
      _relatedProductList = [];
      apiResponse.response!.data.forEach((product) => _relatedProductList!.add(Product.fromJson(product)));
    } 
    else if (apiResponse.response != null){
   _relatedProductList = [];
      apiResponse.response!.data.forEach((product) => _relatedProductList!.add(Product.fromJson(product)));
    }
    
    
    
    
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
  }
  //featured product
  Future<void> getFeaturedProductList(String offset, BuildContext context, {bool reload = false}) async {
    if(reload) {
      _featuredOffsetList = [];
      _featuredProductList = [];
    }
    if(!_featuredOffsetList.contains(offset)) {
      _featuredOffsetList.add(offset);
      ApiResponse apiResponse = await productRepo!.getFeaturedProductList(offset);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _featuredProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        _featuredPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _firstFeaturedLoading = false;
        _isFeaturedLoading = false;
      }  else if (apiResponse.response != null){
_featuredProductList.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        _featuredPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _firstFeaturedLoading = false;
        _isFeaturedLoading = false;
      }
      
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      if(_isFeaturedLoading) {
        _isFeaturedLoading = false;
        notifyListeners();
      }
    }

  }


  Future<void> getRecommendedProduct( BuildContext context) async {
    ApiResponse apiResponse = await productRepo!.getRecommendedProduct();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _recommendedProduct = Product.fromJson(apiResponse.response!.data);
        print('=rex===>${recommendedProduct!.toJson()}');
      }  else   if (apiResponse.response != null){

         _recommendedProduct = Product.fromJson(apiResponse.response!.data);
        print('=rex===>${recommendedProduct!.toJson()}');
      }
      
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();


  }




}
