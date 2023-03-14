import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:eamar_user_app/data/datasource/remote/chache/app_path_provider.dart';
import 'package:eamar_user_app/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  Dio dio;
  String token;
  String countryCode;

  DioClient(this.baseUrl,
      Dio dioC, {
        this.loggingInterceptor,
        this.sharedPreferences,
      }) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    countryCode = sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? AppConstants.languages[0].countryCode;
    print("NNNN $token");
    dio = dioC ?? Dio();
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 30000
      ..options.receiveTimeout = 30000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        AppConstants.LANG_KEY : countryCode == 'US'? 'en':'ar',

      };
    dio.interceptors.add(loggingInterceptor);
    dio.interceptors.add(
        DioCacheInterceptor(options: cacheOptions),
      );
  }

  void updateHeader(String token, String countryCode) {
    token = token == null ? this.token : token;
    countryCode = countryCode == null ? this.countryCode == 'US' ? 'en': this.countryCode.toLowerCase(): countryCode == 'US' ? 'en' : countryCode.toLowerCase();
    this.token = token;
    this.countryCode = countryCode;
    print('===Country code====>$countryCode');
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      AppConstants.LANG_KEY: countryCode == 'US'? 'en':countryCode.toLowerCase(),
    };
  }

  Future<Response> get(String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
        // CachePolicy policy=CachePolicy.refreshForceCache,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
  Options _options;
_options = cacheOptions.copyWith(
  // policy: policy
).toOptions();

    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: _options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> post(String uri, {
    data,      
      // CachePolicy policy=CachePolicy.refreshForceCache,

    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    log(dio.options.headers.toString());
        Options _options;
_options = cacheOptions.copyWith(
  // policy: policy
).toOptions();

    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: _options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  Future<Response> put(String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}




final cacheOptions =  CacheOptions(
  // A default store is required for interceptor.
  // store:  
  
  // // FileCacheStore()
  // MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576)
            store: HiveCacheStore(AppPathProvider.path),
  

  // All subsequent fields are optional.
  
  // Default.
  policy: CachePolicy.request,
  // Returns a cached response on error but for statuses 401 & 403.
  // Also allows to return a cached response on network errors (e.g. offline usage).
  // Defaults to [null].
  hitCacheOnErrorExcept: [401 , 403], //401, 403
  // Overrides any HTTP directive to delete entry past this duration.
  // Useful only when origin server has no cache config or custom behaviour is desired.
  // Defaults to [null].
  maxStale: const Duration(days: 7),
  // Default. Allows 3 cache sets and ease cleanup.
  priority: CachePriority.high,
  // Default. Body and headers encryption with your own algorithm.
  cipher: null,
  // Default. Key builder to retrieve requests.
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  // Default. Allows to cache POST requests.
  // Overriding [keyBuilder] is strongly recommended when [true].
  allowPostMethod: false,
);
