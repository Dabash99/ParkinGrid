import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://graduation-project-apis.herokuapp.com/',
        receiveDataWhenStatusError: true,
        headers:  {
          'Content-Type': 'application/json',
        }
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String token,
  }) async
  {
    dio.options.headers =
    {
      'Authorization': token,
      'Content-Type': 'application/json',

    };

    return await dio.get(
      url,
      queryParameters: query,

    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
    String token,
  }) async
  {
    dio.options.headers =
    {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String token,
  }) async
  {
    dio.options.headers =
    {
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> RegisterPost({
    @required String url,
    Map<String, dynamic> data,
  }) async
  {
    return await dio.post(
      url,
      data: data,
    );
  }
}