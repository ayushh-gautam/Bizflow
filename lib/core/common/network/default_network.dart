import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as web;
import '../../error/failure.dart';
import '../../error/result.dart';

import 'network.dart';

class DefaultNetwork extends Network {
  final web.Client _client;
  // final Preferences preferences;

  DefaultNetwork(
    this._client,
    // this.preferences,
  );

  @override
  Future<Result<T?>> get<T extends ResponseModel>(
    String url, {
    bool? isSecured,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    Uri apiURL;

    if (body != null) {
      String queryString =
          body.entries.map((entry) => '${entry.key}=${entry.value}').join('&');
      apiURL = Uri.parse("$url?$queryString");
    } else {
      apiURL = Uri.parse(url);
    }
    var response = await _client
        .get(apiURL, headers: headers)
        .timeout(const Duration(seconds: 12));

    return _getParsedModel<T>(response);
  }

  Future<Result<T?>> _getParsedModel<T>(web.Response response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var parser = _getParser<T>();
      if (parser != null) {
        if (T == GlobalAPIReponse) {
          return Result.value(GlobalAPIReponse(response.body) as T?);
        } else {
          if (kIsWeb) {
            return Result.value(parser(response.body));
          } else {
            return Result.value(parser(response.body));
          }
        }
      } else {
        return Result.error(AppErrorHandler(
            message: "Unable to decode the response as ${T.runtimeType}",
            status: false));
      }
    } else {
      return Result.error(AppErrorHandler(
          message: response.body,
          status: false,
          code: response.statusCode.toString()));
    }
  }

  Function(String)? _getParser<T>() {
    // if (T == List<ProductModel>) {
    //   return productModelFromJson;
    // } // new new model here
    return null;
  }

  @override
  Future<Result<T?>> getList<T extends List<ResponseModel>?>(Uri url,
      {Map<String, String>? headers}) async {
    var response = await _client.get(url, headers: headers);
    return _getParsedModel<T>(response);
  }

  @override
  Future<Result> post<T extends ResponseModel>(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var response = await _client.post(url,
          headers: headers, body: body, encoding: encoding);
      return _getParsedModel<T>(response);
    } catch (e) {
      return Result.error(
        AppErrorHandler(
          message: "Page not found ${e.runtimeType}",
          status: false,
        ),
      );
    }
  }

  @override
  Future<Result> patch(Uri url, {Object? body}) async {
    try {
      var response = await _client.patch(url, body: body);
      if (response.statusCode == 200) {
        return Result.value(response.body);
      } else {
        return Result.error(AppErrorHandler(
            message: "Something went wrong ${response.runtimeType}",
            status: false,
            code: response.statusCode.toString()));
      }
    } catch (e) {
      return Result.error(AppErrorHandler(
          message: "Page not found ${e.runtimeType}", status: false));
    }
  }

  @override
  Future<Result> delete(Uri url,
      {Map<String, String>? headers, Object? body}) async {
    try {
      var response = await _client.delete(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        return Result.value(response.body);
      } else {
        return Result.value(response.body);
      }
    } catch (e) {
      return Result.error(AppErrorHandler(
          message: "Page not found ${e.runtimeType}", status: false));
    }
  }

  @override
  Future<Result> put<T extends ResponseModel>(Uri url,
      {data, Map<String, String>? headers}) async {
    try {
      var response = await _client.put(url, body: data);

      if (response.statusCode == 200) {
        return Result.value(response);
      } else {
        return Result.error(AppErrorHandler(
            message: "Something went wrong ${response.runtimeType}",
            status: false,
            code: response.statusCode.toString()));
      }
    } catch (e) {
      return Result.error(AppErrorHandler(
          message: "Page not found ${e.runtimeType}", status: false));
    }
  }

  @override
  Future<Result> postList<T extends List<ResponseModel>>(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var response = await _client.post(url, headers: headers, body: body);
      return _getParsedModel<T>(response);
    } catch (e) {
      return Result.error(
        AppErrorHandler(
            message: "Page not found ${e.runtimeType}", status: false),
      );
    }
  }
}
