import 'dart:developer';

import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_view.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/data/repository/category_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';




class CategoryViewState{
  String? value;
  String? subValue;
  // int? currentIndx;
  int? category;
  int? subCategory;
  int? subSubcategory;
  String? title;
  int? itemId;
  CategoryViewState( {
    this.itemId,
    this.title  ,this.subValue ,this.value , 

    this.category ,this.subCategory ,this.subSubcategory
  });

  CategoryViewState copyWith ( 
 String? value , 
  String? subValue, 
  // int? currentIndx;
  int? category , 
  int? subCategory , 
  int? subSubcategory , 
  String? title , 
  int? itemId

  ){
return CategoryViewState(  


  value: value??this.value , 
  category: category??this.category  , 
  subCategory: subCategory??this.subCategory , 
  subSubcategory: subSubcategory?? this.subSubcategory , 
  itemId: itemId??this.itemId , 
  title: title??this.title , 
  subValue: subValue??this.subValue
);
  }
}

class CategoryProvider extends ChangeNotifier {




 CategoryViewState categoryViewState =CategoryViewState(
  value: 'all_categories'
 );





  final CategoryRepo? categoryRepo;

  CategoryProvider({required this.categoryRepo});

List<Product> _brandOrCategoryProductList = [];
List<Product> get brandOrCategoryProductList =>_brandOrCategoryProductList;
  List<Product>? products = [];




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





List<CategoryViewState> tabs2 = [];



bool isProductsLoading=false;


getCategoryProducts(BuildContext context, int category)async{
  log('ITEMID    ${category}');
isProductsLoading= true;
notifyListeners();
  try {
    var apiResponse = await categoryRepo!.getProductsById(category.toString());
 if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        // _categoryList.clear();
        products!.clear();
        apiResponse.response!.data['products'].forEach((category) => products!.add(Product.
        fromJson(category)));
        // products 
        // _categorySelectedIndex = 0;
        notifyListeners();
      }  else  if (apiResponse.response != null){
         products!.clear();
        apiResponse.response!.data['products'].forEach((category) => 
        products!.add(Product.fromJson(category)));
        // _categorySelectedIndex = 0;
      }
      
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
  } catch (e) {
    
  }finally{
    isProductsLoading= false;
    notifyListeners();
  }
}




changeCurrentViewState(
  BuildContext context,
  CategoryViewState state ,  
  
){
log(state.itemId.toString());
if (state.value=="all_categories") {

//  no index
  categoryViewState =CategoryViewState(
  value: 'all_categories' , 
  subValue: 'categoies' , 

 );
}
if (state.value=="subCategory") {
  log("CATEGORY      " +  categoryViewState.category.toString());
    log("SUB      " +  state.subCategory.toString());
categoryViewState =CategoryViewState(
  value: 'subCategory' , 
  subValue: 'categoies' , 
  category: categoryViewState.category, 
  subCategory: state.subCategory
  
 );
notifyListeners();


if (categoryList[categoryViewState.category!]
  
  .subCategories![state.subCategory!].subSubCategories!.isNotEmpty) {
     log("CATEGORY      " +  categoryViewState.category.toString());
    categoryViewState =CategoryViewState(
  value: 'subCategory' , 
  subValue: 'categoies' , 
  category: categoryViewState.category, 
  subCategory: state.subCategory
  
 );
 _subSubCategory.clear();
   _subSubCategory.addAll(
    
    categoryList[categoryViewState.category!]
  
  .subCategories![state.subCategory!].subSubCategories!
   );
//     _subSubCategory.addAll(
//  categoryList[categoryViewState.category!]
  
//   .subCategories![categoryViewState.subCategory!].subSubCategories!
//     );


  }else{
// products!.addAll(categoryList[categoryViewState.currentIndx!])
    categoryViewState =CategoryViewState(
  value: 'subCategory' , 
  subValue: 'product' , 
  category: categoryViewState.category, 
  subCategory: state.subCategory
  
 );
  log("CATEGORY      " +  categoryViewState.category.toString());
getCategoryProducts(context, state.itemId!);



  }
  notifyListeners();
}
if (state.value=="category") {
    log('INDEX    '+ state.category!.toString());

 categoryViewState =CategoryViewState(
  value: 'category' , 
  subValue: 'categoies' , 
  category: state.category
  
 );


 if (categoryList[state.category!].subCategories!.isNotEmpty) {
  categoryViewState =CategoryViewState(
  value: 'category' , 
  subValue: 'categoies' , 
  category: state.category
  
 );
  _subCategroies.clear();
    _subCategroies.addAll(
      categoryList[state.category!].subCategories!
    );
    notifyListeners();
    
  }else{
// products!.addAll(categoryList[categoryViewState.currentIndx!])
 categoryViewState =CategoryViewState(
  value: 'category' , 
  subValue: 'product' , 
  category: state.category
  
 );

getCategoryProducts(context, state.itemId!);



  }

}
if (state.value=="subSubCategory") {
categoryViewState =CategoryViewState(
  value: 'subSubCategory' , 
  subValue: 'product' , 
  category: categoryViewState.category , 

   subCategory: categoryViewState.subCategory,
  subSubcategory: state.subSubcategory
 );


getCategoryProducts(context, state.itemId!);
}


notifyListeners();
}









List<CategoryViewState> getCategoryTitles(BuildContext context , ){

  if (categoryList[categoryViewState.category!].subCategories!.isNotEmpty) {
   
 
 
 tabs2 = [

CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
   
subValue: 'categoies' , 
value: 'category' ,
itemId:  categoryList[categoryViewState.category!].id , 
category: categoryViewState.category 
    ), 
CategoryViewState (
      title:
  getLang(context)=="ar"?
    "الفئات" 
    :"Categories",
subValue: 'categoies' , 
value: 'category' ,
itemId:  categoryList[categoryViewState.category!].id , 
category: categoryViewState.category 
    ), 

  ];

  }else{
// products!.addAll(categoryList[categoryViewState.currentIndx!])

tabs2 = [

   
    CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
   
subValue: 'categoies' , 
value: 'category' ,
category: categoryViewState.category ,
itemId:  categoryList[categoryViewState.category!].id , 
    ), 
CategoryViewState (
      title:
   getLang(context)=="ar"?
    "المنتجات" 
    :"Products",
subValue: 'product' , 
value: 'category' ,
category: categoryViewState.category ,
itemId:  categoryList[categoryViewState.category!].id , 
    ), 

  ];
  notifyListeners();

  }
 if (categoryViewState.value=="subCategory") {
 
  if (categoryList[categoryViewState.category!]
  
  .subCategories![categoryViewState.subCategory!].subSubCategories!.isNotEmpty) {
  //  _subSubCategory.addAll(
    
  //   categoryList[categoryViewState.category!]
  
  // .subCategories![categoryViewState.subCategory!].subSubCategories!
  //  );
//     _subSubCategory.addAll(
//  categoryList[categoryViewState.category!]
  
//   .subCategories![categoryViewState.subCategory!].subSubCategories!
//     );
 tabs2 = [

  
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
subValue: 'categoies' , 
value: 'category' ,
itemId: categoryList[categoryViewState.category!].id,
category: categoryViewState.category , 
subCategory: categoryViewState.subCategory
    ), 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].name,
   itemId:
     categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].id ,
subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category , 
subCategory: categoryViewState.subCategory
    ), 

CategoryViewState (
      title:
  getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories",
   itemId:
     categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].id ,
subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category , 
subCategory: categoryViewState.subCategory
    ), 


  ];

  }else {


 tabs2 = [

  
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
subValue: 'categoies' , 
value: 'category' ,category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId:  categoryList[categoryViewState.category!].id
    ), 

    CategoryViewState (
      title:
   categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].name,
subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId: categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].id
    ), 

  
  
  ];


  }

  }


 if (categoryViewState.value=="subSubCategory") {
  tabs2 = [

 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
   itemId:  categoryList[categoryViewState.category!].id,
subValue: 'categoies' , 
value: 'category' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
    ), 
    CategoryViewState (
      title:
   categoryList[categoryViewState.category!].subCategories![categoryViewState.subSubcategory!].name,
   itemId: categoryList[categoryViewState.category!].subCategories![categoryViewState.subSubcategory!].id,

subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
    ), 

     CategoryViewState (
      title:
   categoryList[categoryViewState.category!].
   subCategories![categoryViewState.subCategory!].subSubCategories!
   
   [categoryViewState.subSubcategory!].name,
   itemId: categoryList[categoryViewState.category!].
   subCategories![categoryViewState.subCategory!].subSubCategories!
   
   [categoryViewState.subSubcategory!].id,
   category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
subValue: 'categoies' , 
value: 'subSubCategory' ,

    ), 
CategoryViewState (
      title:
   getLang(context)=="ar"?
    "كل المنتجات" 
    :"All Products",
subValue: 'product' , 
value: 'subSubCategory' ,

category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId: categoryList[categoryViewState.category!].
   subCategories![categoryViewState.subCategory!].subSubCategories!
   
   [categoryViewState.subSubcategory!].id , 


    ), 
  ];
 


  notifyListeners();

if (categoryViewState.itemId!=null) {
    getCategoryProducts(context, categoryViewState.itemId!);
  }
}




  return tabs2;


}

List<CategoryViewState>

getTabsTitles(BuildContext context ){
if (categoryViewState.value=="all_categories") {
  tabs2 = [

   CategoryViewState (
      title:
    getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories"
, subValue: 'all' , 
value: 'all_categories'
    )
  ];

  
}
 if (categoryViewState.value=="category") {


  if (categoryList[categoryViewState.category!].subCategories!.isNotEmpty) {
   
 
 
 tabs2 = [

   CategoryViewState (
      title:
    getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories"
, subValue: 'all' , 
value: 'all_categories'
    ), 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
   
subValue: 'categoies' , 
value: 'category' ,
itemId:  categoryList[categoryViewState.category!].id , 
category: categoryViewState.category 
    ), 

  ];

  }else{
// products!.addAll(categoryList[categoryViewState.currentIndx!])

tabs2 = [

   CategoryViewState (
      title:
    getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories"
, subValue: 'all' , 
value: 'all_categories' , 
itemId:  categoryList[categoryViewState.category!].id , 
    ), 
    CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
   
subValue: 'categoies' , 
value: 'category' ,
category: categoryViewState.category ,
itemId:  categoryList[categoryViewState.category!].id , 
    ), 
CategoryViewState (
      title:
   getLang(context)=="ar"?
    "المنتجات" 
    :"Products",
subValue: 'product' , 
value: 'category' ,
category: categoryViewState.category ,
itemId:  categoryList[categoryViewState.category!].id , 
    ), 

  ];
  notifyListeners();




  }
 

  
} 


 if (categoryViewState.value=="subCategory") {
 
  if (categoryList[categoryViewState.category!]
  
  .subCategories![categoryViewState.subCategory!].subSubCategories!.isNotEmpty) {
  //  _subSubCategory.addAll(
    
  //   categoryList[categoryViewState.category!]
  
  // .subCategories![categoryViewState.subCategory!].subSubCategories!
  //  );
//     _subSubCategory.addAll(
//  categoryList[categoryViewState.category!]
  
//   .subCategories![categoryViewState.subCategory!].subSubCategories!
//     );
 tabs2 = [

   CategoryViewState (
      title:
    getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories"
, subValue: 'all' , 
value: 'all_categories', 

    ), 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
subValue: 'categoies' , 
value: 'category' ,
itemId: categoryList[categoryViewState.category!].id,
category: categoryViewState.category , 
subCategory: categoryViewState.subCategory
    ), 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].name,
   itemId:
     categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].id ,
subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category , 
subCategory: categoryViewState.subCategory
    ), 
  ];

  }else {


 tabs2 = [

   CategoryViewState (
      title:
    getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories"
, subValue: 'all' , 
value: 'all_categories'
    ), 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
subValue: 'categoies' , 
value: 'category' ,category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId:  categoryList[categoryViewState.category!].id
    ), 

    CategoryViewState (
      title:
   categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].name,
subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId: categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].id
    ), 

    CategoryViewState (
      title:
  getLang(context)=="ar"?
    "الفئات" 
    :"Categories",
subValue: 'product' , 
value: 'subCategory' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId: categoryList[categoryViewState.category!].subCategories![categoryViewState.subCategory!].id
    ), 
  ];


  }

  }
  
  
//   else{
// // products!.addAll(categoryList[categoryViewState.currentIndx!])
// tabs2 = [

//    CategoryViewState (
//       title:
//     getLang(context)=="ar"?
//     "كل الفئات" 
//     :"All Categories"
// , subValue: 'all' , 
// value: 'all_categories'
//     ), 
// CategoryViewState (
//       title:
//    categoryList[categoryViewState.category!].name,
// subValue: 'categoies' , 
// value: 'category' ,

//     ), 
// CategoryViewState (
//       title:
//    getLang(context)=="ar"?
//     "المنتجات" 
//     :"Products",
// subValue: 'product' , 
// value: 'SubCategory' ,

//     ), 
//   ];
 
//   notifyListeners();
// // getCategoryProducts(context, categoryViewState.subCategory!);



  

  
// }
if (categoryViewState.value=="subSubCategory") {
  tabs2 = [

   CategoryViewState (
      title:
    getLang(context)=="ar"?
    "كل الفئات" 
    :"All Categories"
, subValue: 'all' , 
value: 'all_categories'
    ), 
CategoryViewState (
      title:
   categoryList[categoryViewState.category!].name,
   itemId:  categoryList[categoryViewState.category!].id,
subValue: 'categoies' , 
value: 'category' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
    ), 
    CategoryViewState (
      title:
   categoryList[categoryViewState.category!].subCategories![categoryViewState.subSubcategory!].name,
   itemId: categoryList[categoryViewState.category!].subCategories![categoryViewState.subSubcategory!].id,

subValue: 'categoies' , 
value: 'subCategory' ,
category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
    ), 

     CategoryViewState (
      title:
   categoryList[categoryViewState.category!].
   subCategories![categoryViewState.subCategory!].subSubCategories!
   
   [categoryViewState.subSubcategory!].name,
   itemId: categoryList[categoryViewState.category!].
   subCategories![categoryViewState.subCategory!].subSubCategories!
   
   [categoryViewState.subSubcategory!].id,
   category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
subValue: 'categoies' , 
value: 'subSubCategory' ,

    ), 
CategoryViewState (
      title:
   getLang(context)=="ar"?
    "كل المنتجات" 
    :"All Products",
subValue: 'product' , 
value: 'subSubCategory' ,

category: categoryViewState.category,
subCategory:categoryViewState.subCategory, 
itemId: categoryList[categoryViewState.category!].
   subCategories![categoryViewState.subCategory!].subSubCategories!
   
   [categoryViewState.subSubcategory!].id , 


    ), 
  ];
 


  notifyListeners();

  if (categoryViewState.itemId!=null) {
    getCategoryProducts(context, categoryViewState.itemId!);
  }


}




notifyListeners();

return tabs2;
}

}
class TabModel{
  String? value;
  String? title;
  int? itemIndex;
  String? sub;
  bool? haSub;
  TabModel({
    this.sub ,this.title ,this.value ,this.itemIndex , 
    this.haSub=false
  });
}

class TabSelection{

  String? value;
  String? subValues;
  String? title;
   bool? haSub;
   int? itemIndex;
   TabSelection( {
    this.subValues,
    this.haSub, this.itemIndex, this.title , this.value
   });
}