import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/data/repository/category_repo.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/data/repository/search_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;
  final CategoryRepo categoryRepo;
  SearchProvider({@required this.searchRepo , this.categoryRepo});





Category  _category;


Category   get category=> _category;



setCategory(Category cat){
  _category=cat;
  notifyListeners();
}



  int _filterIndex = 0;
  List<String> _historyList = [];

  List<Category> _categories=[];



 List<Category> get categoryList  => _categories;
  int get filterIndex => _filterIndex;
  List<String> get historyList => _historyList;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }
  Future<void> getCategoryList(bool reload, BuildContext context) async {
    if (_categories.length == 0 || reload) {
      ApiResponse apiResponse = await categoryRepo.getCategoryList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _categories.clear();
        apiResponse.response.data.forEach((category) => _categories.add(Category.fromJson(category)));
        // _categorySelectedIndex = 0;
      }else   if (apiResponse.response != null){

         _categories.clear();
        apiResponse.response.data.forEach((category) => _categories.add(Category.fromJson(category)));
      }
      
      
      
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }
  void sortSearchList(double startingPrice, double endingPrice) {
    _searchProductList = [];
    if(startingPrice > 0 && endingPrice > startingPrice) {
      _searchProductList.addAll(_filterProductList.where((product) =>
      (product.unitPrice) > startingPrice && (product.unitPrice) < endingPrice).toList());
    }else {
      _searchProductList.addAll(_filterProductList);
    }

    if (_filterIndex == 0) {

    } else if (_filterIndex == 1) {
      _searchProductList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (_filterIndex == 2) {
      _searchProductList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    } else if (_filterIndex == 3) {
      _searchProductList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
    } else if (_filterIndex == 4) {
      _searchProductList.sort((a, b) => a.unitPrice.compareTo(b.unitPrice));
      Iterable iterable = _searchProductList.reversed;
      _searchProductList = iterable.toList();
    }

    notifyListeners();
  }

  List<Product> _searchProductList;
  List<Product> _filterProductList;
  bool _isClear = true;
  String _searchText = '';

  List<Product> get searchProductList => _searchProductList;
  List<Product> get filterProductList => _filterProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void cleanSearchProduct() {
    _searchProductList = [];
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }

  void searchProduct(String query, BuildContext context) async {
    _searchText = query;
    _isClear = false;
    _searchProductList = null;
    _filterProductList = null;
    notifyListeners();

    ApiResponse apiResponse = await searchRepo.getSearchProductList(query);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      if (query.isEmpty) {
        _searchProductList = [];
      } else {
        _searchProductList = [];
        _searchProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        _filterProductList = [];
        _filterProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
      }
    }  else   if (apiResponse.response != null){
 if (query.isEmpty) {
        _searchProductList = [];
      } else {
        _searchProductList = [];
        _searchProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        _filterProductList = [];
        _filterProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
      }

    }
    
    
    
     else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
 void filterByBudgetAndCategory(Category cat, budget, BuildContext context) async {
    _searchText = "Cat: ${cat.name},Amount:${budget}";
    _isClear = false;
    _searchProductList = null;
    _filterProductList = null;
    notifyListeners();

    ApiResponse apiResponse = await searchRepo.filterByBudget(cat.id , budget);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      // if (query.isEmpty) {
      //   _searchProductList = [];
      // } else {
        _searchProductList = [];
        Iterable data = apiResponse.response.data;
        _searchProductList=data.map((product)=>Product.fromJson(product)).toList();
        
        // addAll(ProductModel.fromJson(apiResponse.response.data).products);
        _filterProductList = [];
        _filterProductList.addAll(_searchProductList);
      // }
    } else   if (apiResponse.response != null){
  _searchProductList = [];
        Iterable data = apiResponse.response.data;
        _searchProductList=data.map((product)=>Product.fromJson(product)).toList();
        
        // addAll(ProductModel.fromJson(apiResponse.response.data).products);
        _filterProductList = [];
        _filterProductList.addAll(_searchProductList);

    }
    
    
    
    else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void initHistoryList() {
    _historyList = [];
    _historyList.addAll(searchRepo.getSearchAddress());
    notifyListeners();
  }

  void saveSearchAddress(String searchAddress) async {
    searchRepo.saveSearchAddress(searchAddress);
    if (!_historyList.contains(searchAddress)) {
      _historyList.add(searchAddress);
    }
    notifyListeners();
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchAddress();
    _historyList = [];
    notifyListeners();
  }
}
