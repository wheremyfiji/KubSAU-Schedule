import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../../secret.dart';

class DioNetworkService implements NetworkService {
  DioNetworkService() {
    dio = Dio(baseOptions);

    dio.interceptors.add(RetryInterceptor(
        dio: dio,
        logPrint: log,
        retries: 1,
        retryDelays: const [
          Duration(seconds: 4),
        ]));

    dio.interceptors.add(RequestInterceptors(dio));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: false,
      ));
    }
  }

  late final Dio dio;

  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 30),
      );

  @override
  String get baseUrl => kApiBaseUrl;

  @override
  Map<String, String> headers = {
    'Accept': 'application/json',
  };

  /// GET method
  @override
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

abstract class NetworkService {
  /// Http base url
  String get baseUrl;

  /// Http headers
  Map<String, String> get headers;

  /// Http get request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}

class RequestInterceptors extends Interceptor {
  final Dio dio;

  RequestInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      handler.reject(
        NoInternetConnectionException(options),
      );
      return;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          //case 401:
          //  break;
          //  throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 422:
            throw BadResponceErrorException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.unknown:
        throw UnknownErrorException(err.requestOptions);
      //break;
    }
    //super.onError(err, handler);
    return handler.next(err);
  }
}

class BadResponceErrorException extends DioException {
  BadResponceErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Код ошибки 422 (Bad Responce)';
  }
}

class UnknownErrorException extends DioException {
  UnknownErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Произошла неизвестная ошибка, попробуй позже';
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Ошибка сервера, попробуй позже';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Ошибка 404. Ничего не найдено';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Проверь свое подключение к интернету';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
