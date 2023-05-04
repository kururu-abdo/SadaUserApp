import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/data/repository/category_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;

  CategoryProvider({@required this.categoryRepo});


  List<Category> _categoryList = [];
  int _categorySelectedIndex;
  List<SubCategory> _subCategroies = [];
    List<SubSubCategory> _subSubCategory = [];
 List<SubSubCategory>    get subSubCategroies   => _subSubCategory;

 List<SubCategory>    get subCategroies   => _subCategroies;
  List<Category> get categoryList => _categoryList;
  int get categorySelectedIndex => _categorySelectedIndex;

  Future<void> getCategoryList(bool reload, BuildContext context) async {
    if (_categoryList.length == 0 || reload) {
      ApiResponse apiResponse = await categoryRepo.getCategoryList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response.data.forEach((category) => _categoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
      }  else  if (apiResponse.response != null){
         _categoryList.clear();
        apiResponse.response.data.forEach((category) => _categoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
      }
      
      
       else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }


getSubCategries(){
  try {
    var data= _categoryList[_categorySelectedIndex].subCategories;
_subCategroies.clear();
    _subCategroies.addAll(data);
    notifyListeners();
  } catch (e) {
  }
}
getSubSubCategries(int sub){
  try {
    var data= _subCategroies.where((element) => element.id==sub).first;

_subSubCategory.clear();
    _subSubCategory.addAll(data.subSubCategories);
    print("BRAND"+_subSubCategory.length.toString());
    notifyListeners();
  } catch (e) {
  }
}

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
}
