import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../models/exceptions.dart';

class HttpHelper {
  final Client client;

  const HttpHelper._({
    required this.client,
  });

  static HttpHelper? _instance;

  factory HttpHelper({required Client client}) {
    _instance ??= HttpHelper._(client: client);
    return _instance as HttpHelper;
  }

  Future<String> get(String url) async {
    late final Response response;
    try {
      response = await client.get(
        Uri.parse(url),
        headers: const {'Content-Type': 'application/json'},
      );
    } on SocketException catch (_) {
      throw const NoInternet();
    }

    if (response.statusCode >= 200 && response.statusCode < 400) {
      return utf8.decode(response.bodyBytes);
    }

    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw const BadRequest();
    }

    throw const ServerError();
  }
}
