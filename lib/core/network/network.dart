import 'dart:convert';

import '../error/result.dart';

abstract class ResponseModel {}

class GlobalAPIReponse extends ResponseModel {
  dynamic data;
  GlobalAPIReponse(this.data);
}

abstract class Network {
  Future<Result<T?>> get<T extends ResponseModel>(
    String url, {
    bool? isSecured,
    Map<String, String>? headers,
    Map<String, String>? body,
  });

  Future<Result<T?>> getList<T extends List<ResponseModel>?>(
    Uri url, {
    Map<String, String>? headers,
  });

  Future<Result> post<T extends ResponseModel>(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding});

  Future<Result> postList<T extends List<ResponseModel>>(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding});

  Future<Result> patch(Uri url, {Object? body});

  Future<Result> delete(Uri url, {Map<String, String>? headers, Object? body});

  Future<Result> put<T extends ResponseModel>(Uri url,
      {dynamic data, Map<String, String>? headers});
}