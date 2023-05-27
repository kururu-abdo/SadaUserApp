import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:eamar_user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:eamar_user_app/data/model/response/new_job_model.dart';
import 'package:eamar_user_app/utill/app_constants.dart';

import '../model/response/base/api_response.dart';

class JobsRepo {
  final DioClient? dioClient;
  JobsRepo({required this.dioClient});

//functions
    Future<ApiResponse> getJobs(BuildContext context, String lang) async {
   
    try {
      final response = await dioClient!.get(
        AppConstants.GET_JOBS+"?lang=${lang}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



 Future<ApiResponse> getUsersJobs(BuildContext context, String lang) async {
   
    try {
      final response = await dioClient!.get(
        AppConstants.GET_JOBS_LIST+"?lang=${lang}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




 Future<ApiResponse> getRegions(BuildContext context, String lang) async {
   
    try {
      final response = await dioClient!.get(
        AppConstants.GET_REGIONS+"?lang=${lang}");
        log('REGIONS'+  response.data.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }





Future<ApiResponse> getCities(BuildContext context , int? region, String lang) async {
   
    try {
      final response = await dioClient!.get(
        AppConstants.GET_REGION_CITIES+"/${region}?lang=${lang}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



Future<ApiResponse> searchAJobs(BuildContext context , int? city , int? jobId, String lang) async {
   
    try {
      final response = await dioClient!.post(
        AppConstants.SEARCH_JOBS+"?lang=${lang}" ,

        data: {
          "user_job_id" : jobId , "city_id" : city
        }
        
        
        );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



Future<ApiResponse> addAjob(BuildContext context ,

NewJobModel addJobModel
) async {


// log(addJobModel.toJson().toString());
   
    try {
      final response = await dioClient!.post(
        AppConstants.ADD_JOBS ,

        data: addJobModel.toJson()
        );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}