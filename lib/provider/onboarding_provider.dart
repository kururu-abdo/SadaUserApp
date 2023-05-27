import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/onboarding_model.dart';
import 'package:eamar_user_app/data/repository/onboarding_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';

class OnBoardingProvider with ChangeNotifier {
  final OnBoardingRepo? onboardingRepo;

  OnBoardingProvider({required this.onboardingRepo});

  List<OnboardingModel> _onBoardingList = [];
  List<OnboardingModel> get onBoardingList => _onBoardingList;

  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  changeSelectIndex(int index){
    _selectedIndex=index;
    notifyListeners();
  }

  void initBoardingList(BuildContext context) async {
    ApiResponse apiResponse = await onboardingRepo!.getOnBoardingList(context);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _onBoardingList.clear();
      _onBoardingList.addAll(apiResponse.response!.data);
    }
    else  if (apiResponse.response != null ) {
      _onBoardingList.clear();
      _onBoardingList.addAll(apiResponse.response!.data);
    }
    
    
     else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
