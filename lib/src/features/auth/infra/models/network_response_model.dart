import 'dart:convert';

import '../../domain/entities/network_response_entity.dart';

enum Method { get, post, delete, put, patch }

class NetworkResponseModel extends NetworkResponse {
  NetworkResponseModel({
    super.body,
    super.headers,
    super.statusCode,
    super.url,
    super.method,
  });

  static NetworkResponseModel noResponse() => NetworkResponseModel(
    statusCode: 0,
    url: "",
    body: {"error": "No response found"},
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (method != null) {
      result.addAll({'method': method});
    }
    if (statusCode != null) {
      result.addAll({'statusCode': statusCode});
    }
    if (url != null) {
      result.addAll({'url': url});
    }
    if (body != null) {
      result.addAll({'body': body});
    }
    if (headers != null) {
      result.addAll({'headers': headers});
    }

    return result;
  }

  factory NetworkResponseModel.fromMap(Map<String, dynamic> map) {
    return NetworkResponseModel(
      statusCode: map['statusCode'],
      method: map['method'],
      url: map['url'],
      body: map['body'],
      headers: map['headers'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NetworkResponseModel.fromJson(dynamic map) =>
      NetworkResponseModel.fromMap(json.decode(map));

  static String? getMethodName(Method? method) {
    switch (method) {
      case (Method.get):
        return "GET";
      case (Method.post):
        return "POST";
      case (Method.delete):
        return "DELETE";
      case (Method.put):
        return "PUT";
      case (Method.patch):
        return "PATCH";
      default:
        return null;
    }
  }
}
