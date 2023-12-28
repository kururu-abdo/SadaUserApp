import 'dart:developer';

import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/data/repository/category_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo? categoryRepo;

  CategoryProvider({required this.categoryRepo});

List<Product> _brandOrCategoryProductList = [];
List<Product> get brandOrCategoryProductList =>_brandOrCategoryProductList;





  List<Category> _categoryList = [];
  
  List<SubCategory> _subCategroies = [];
    List<SubSubCategory> _subSubCategory = [];
 List<SubSubCategory>    get subSubCategroies   => _subSubCategory;
 bool? _hasData;
 List<SubCategory>    get subCategroies   => _subCategroies;
  List<Category> get categoryList => _categoryList;

  int? _categorySelectedIndex;
  int? get categorySelectedIndex => _categorySelectedIndex;





 int? _subCategorySelectedIndex;
  int? get subCategorySelectedIndex => _subCategorySelectedIndex;

int? _subSubCategorySelectedIndex;
  int? get subSubCategorySelectedIndex => _subSubCategorySelectedIndex;


 bool? _isLoading;
  bool? get isLoading => _isLoading;




  Future<void> getCategoryList(bool reload, BuildContext context) async {
       _categoryList.clear();
      
    if (_categoryList.length == 0 || reload) {
      ApiResponse apiResponse = await categoryRepo!.getCategoryList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response!.data.forEach((category) => _categoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
        notifyListeners();
      }  else  if (apiResponse.response != null){
         _categoryList.clear();
        apiResponse.response!.data.forEach((category) => _categoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
      }
      
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }


Future<void>  getSubCategries()async{
  try {
    var data= _categoryList[_categorySelectedIndex!].subCategories!;
_subCategroies.clear();
    _subCategroies.addAll(data);

    if (_subCategroies.length>0) {
      
    }
    notifyListeners();
  } catch (e) {
  }
}



Future<void>  initSubCategory(
  BuildContext context,
  Category category
)async{
  try {
    var data= category.subCategories!;
_subCategroies.clear();
    _subCategroies.addAll(data);

     if (_subCategroies.length>0) {

if (    _subCategroies.first.subSubCategories!.length>0) {

_subSubCategory.clear();
        
_subSubCategory.addAll( _subCategroies.first.subSubCategories!);
// getSubSubCategries(category.id);
  log('There is Sub Categories');
        filterBrandAndCategoryProductList(context, _subCategroies.first.subSubCategories!.first.id);
      
      }else {
        log('There NOOOO Sub Categories');
          filterBrandAndCategoryProductList(context, _subCategroies.first.id);
      }

    
      
    }else {
       log('JUST PRODUCTS');
       _subSubCategory.clear();
        _subCategroies.clear();

        filterBrandAndCategoryProductList(context, category.id);
    }
    notifyListeners();
  } catch (e) {
  }
}



getSubSubCategries(int? sub){
  try {
    var data= _subCategroies.where((element) => element.id==sub).first;

_subSubCategory.clear();
    _subSubCategory.addAll(data.subSubCategories!);
    print("BRAND"+_subSubCategory.length.toString());
    notifyListeners();
  } catch (e) {
  }
}

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    _subCategorySelectedIndex =0;
    notifyListeners();
  }
void changeSelectedSubCategory(int index){
  _subCategorySelectedIndex =  index;
  notifyListeners();
}

void changeSelectedSubSubCategory(int index){
  _subSubCategorySelectedIndex =  index;
  notifyListeners();
}











 Future<void> initBrandOrCategoryProductList(bool isBrand, String id, BuildContext context) async {
    _brandOrCategoryProductList.clear();
    _hasData = true;
      notifyListeners();

    ApiResponse apiResponse = await  categoryRepo!.getBrandOrCategoryProductList(isBrand, id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((product) => 
      
      _brandOrCategoryProductList.add(Product.fromJson(product)));
      _hasData = _brandOrCategoryProductList.length > 1;
      List<Product> _products = [];
      _products.addAll(_brandOrCategoryProductList);
      _brandOrCategoryProductList.clear();
      // brandOrCategoryProductList2.clear();

      _brandOrCategoryProductList.addAll(_products.reversed);
      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


filterBrandAndCategoryProductList(BuildContext context,int? category)async{
  _brandOrCategoryProductList.clear();
    _hasData = true;
    _isLoading=true;
    ApiResponse apiResponse = await categoryRepo!.getProductsById(category.toString());
   
   
       log(apiResponse.response!.statusCode.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
   _brandOrCategoryProductList.clear();
      apiResponse.response!.data['products'].forEach((product) => 
      _brandOrCategoryProductList.add(Product.fromJson(product)));
      _hasData = _brandOrCategoryProductList.length > 1;
      List<Product> _products = [];
      _products.addAll(_brandOrCategoryProductList);
      // _brandOrCategoryProductList.addAll();
      // _brandOrCategoryProductList2.clear();
// 
      _brandOrCategoryProductList.addAll(_products.reversed);
      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
    _isLoading=false;

          notifyListeners();

    } else  if (apiResponse.response != null){
_brandOrCategoryProductList.clear();
      apiResponse.response!.data['products'].forEach((product) => 
      _brandOrCategoryProductList.add(Product.fromJson(product)));
      _hasData = _brandOrCategoryProductList.length > 1;
      List<Product> _products = [];
      _products.addAll(_brandOrCategoryProductList);
      // _brandOrCategoryProductList.addAll();
      // _brandOrCategoryProductList2.clear();
// 
      _brandOrCategoryProductList.addAll(_products.reversed);
      // brandOrCategoryProductList2.addAll(_brandOrCategoryProductList);
    _isLoading=false;

          notifyListeners();
    }
     else {
      log('HERE IS PROBELM');
      log(apiResponse.error.toString());
      ApiChecker.checkApi(context, apiResponse);
    }
        _isLoading=false;

    notifyListeners();
}





}
