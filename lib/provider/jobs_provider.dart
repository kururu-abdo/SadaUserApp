import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/base/api_response.dart';
import 'package:eamar_user_app/data/model/response/base/error_response.dart';
import 'package:eamar_user_app/data/model/response/city.dart';
import 'package:eamar_user_app/data/model/response/job_model.dart';
import 'package:eamar_user_app/data/model/response/new_job_model.dart';
import 'package:eamar_user_app/data/model/response/region.dart';
import 'package:eamar_user_app/data/model/response/user_job.dart';
import 'package:eamar_user_app/data/repository/jobs_repo.dart';
import 'package:eamar_user_app/data/repository/product_repo.dart';
import 'package:eamar_user_app/helper/api_checker.dart';

class JobsProvider extends ChangeNotifier {
  final JobsRepo jobsRepo;
  JobsProvider({@required this.jobsRepo});


  bool _filterIsLoading = false;
  bool get filterIsLoading => _filterIsLoading;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
bool _isAddJobLoading = false;
  bool get isAddJobLoading => _isAddJobLoading;

    bool _isJobsLoading = true;
  bool get isJobsLoading=> _isJobsLoading;


  bool _searchIsLoading = false;
  bool get searchIsLoading => _searchIsLoading;


bool _isRegionsLoading=true;
  bool get isRegionsLoading => _isRegionsLoading;


bool _isCitiesLoading=true;
  bool get isCitiesLoading => _isCitiesLoading;

List<Region>  regions=[];

List<Job>  jobs=[];
List<UserJob>  userJobs=[];


List<City>  cities=[];

List<UserJob>  jobSearchResults=[];


//get jobs by city and category





//get all jobs


Future<void> getJobs( BuildContext context ,String lang, {bool reload = false}) async {
    if(reload) {
      jobs = [];
    }
   if (jobs.length>0) {
             jobs = [];

     }
     
     
      ApiResponse apiResponse = await jobsRepo.getUsersJobs(context ,lang);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
log(apiResponse.response.data.runtimeType.toString());
Iterable data=  apiResponse.response.data;
        List<Job> _jobs= 
         data.
        map
        ((data)=>Job.fromJson(data))
        .toList();
        jobs.addAll(_jobs);
       
        _isLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }

  

//get users jobs


Future<void> getUserJobs( BuildContext context ,String lang, {bool reload = false}) async {
  //   if(reload) {
  //     userJobs = [];
  //   }
  //  if (userJobs.length>0) {
  //            userJobs = [];

  //    }
     
     
      ApiResponse apiResponse = await jobsRepo.getJobs(context ,lang);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
Iterable data= apiResponse.response.data;
        List<UserJob> _jobs= data.map((data)=>UserJob.fromJson(data)).toList();
        userJobs = [];
        userJobs.addAll(_jobs);
       
        _isJobsLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }

  




//search job


Future<void> searchAJob( BuildContext context  , int city , int job,String lang, {bool reload = false}) async {
    if(reload) {
      userJobs = [];
    }
  if (userJobs.length>0) {
     userJobs = [];
  }
  log(job.toString());
  log(city.toString());
     _isJobsLoading=true;
     notifyListeners();
     
      ApiResponse apiResponse = await jobsRepo.searchAJobs(context, city , job  ,lang);
      log('AFTER RESPONSE');
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
    
if (job==null) {
   log('JOB NULL');
  var data=apiResponse.response.data ;

 if (data is Map) {
    for (var key in (data as Map).keys) {
      
  userJobs.add(UserJob.fromJson(data[key]));
  }
 }else {
   Iterable data  =apiResponse.response.data;


     var _jobs=  data.map((data)=>UserJob.fromJson(data)).toList();
        userJobs.addAll(_jobs);

log('message');
      _isJobsLoading=false;
     notifyListeners(); 
     
 }

  log('message');
      _isJobsLoading=false;
     notifyListeners(); 
}


else{
   log('JOB NOT NULL');

Iterable data  =apiResponse.response.data;


     var _jobs=  data.map((data)=>UserJob.fromJson(data)).toList();
        userJobs.addAll(_jobs);

log('message');
      _isJobsLoading=false;
     notifyListeners(); 
     
}
       
      } else {
 log('OUTSEIDE IF');
        _isJobsLoading = false;
        notifyListeners();

        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }

  //add job

  Future<void> addJob( BuildContext context , NewJobModel newJob ,   Function callback) async {
   
  
     _isAddJobLoading=true;
     notifyListeners();
     
      ApiResponse apiResponse = await jobsRepo.addAjob(context ,newJob);

        if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      
      _isAddJobLoading=false;
     notifyListeners();
      callback(true, "تمت اضافة المهنة بنجاح", null);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }

      _isAddJobLoading=false;
     notifyListeners();
      callback(false, '', errorMessage);
      notifyListeners();
    }
    }

  

//filter search



//get regions



Future<void> getRegions( BuildContext context ,String lang, {bool reload = false}) async {

  log('GET REGIONS---------------------------------');
    if(reload) {
      regions = [];
    }
  
    if (regions.length>0) {
             regions = [];

     }
     
      ApiResponse apiResponse = await jobsRepo.getRegions(context ,lang);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
Iterable data= apiResponse.response.data;


        var _jobs=  data.map((data)=>Region.fromJson(data)).toList();

        
        regions.addAll(_jobs);
       
        _isRegionsLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }

  

//get cities



Future<void> getCities( BuildContext context , int region ,String lang, {bool reload = false}) async {
    if(reload) {
      cities = [];
    }
  _isCitiesLoading=true;
  notifyListeners();
     if (cities.length>1) {
        cities = [];
     }
     
      ApiResponse apiResponse = await jobsRepo.getCities(context, region ,lang);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
Iterable data=apiResponse.response.data;
        var _jobs=  data.map((data)=>City.fromJson(data)).toList();
        cities.addAll(_jobs);
       
        _isCitiesLoading = false;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }

  

}