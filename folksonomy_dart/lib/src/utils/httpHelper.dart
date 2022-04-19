import 'dart:async';
import 'dart:convert';

import 'package:folksonomy_dart/src/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'QueryType.dart';
import 'configuration/folksonomyApiConfiguration.dart';

/// General functions for sending http requests (post, get, multipart, ...)
class HttpHelper {
  /// Gets the instance
  static HttpHelper get instance => _instance ??= HttpHelper.internal();
  static HttpHelper? _instance;
  @visibleForTesting
  static set instance(HttpHelper value) => _instance = value;

  factory HttpHelper() => instance;

  @protected

  /// A protected constructor to allow subclasses to create themselves.
  HttpHelper.internal();

  static const String USER_AGENT = 'Dart API';
  static const String FROM = 'anonymous';

  /// Adds user agent data to parameters, for statistics purpose
  // static Map<String, dynamic>? addUserAgentParameters(
  //   Map<String, dynamic>? map,
  // ) {
  //   if (FolksonomyAPIConfiguration.userAgent?.name != null) {
  //     map ??= <String, dynamic>{};
  //     map['app_name'] = FolksonomyAPIConfiguration.userAgent!.name!;
  //   }
  //   if (FolksonomyAPIConfiguration.userAgent?.version != null) {
  //     map ??= <String, String>{};
  //     map['app_version'] = FolksonomyAPIConfiguration.userAgent!.version!;
  //   }
  //   if (FolksonomyAPIConfiguration.uuid != null) {
  //     map ??= <String, String>{};
  //     map['app_uuid'] = FolksonomyAPIConfiguration.uuid!;
  //   }
  //   return map;
  // }

  /// Send a http get request to the specified uri.
  /// The data of the request (if any) has to be provided as parameter within the uri.
  /// The result of the request will be returned as string.
  /// By default the query will hit the PROD DB
  Future<http.Response> doGetRequest(Uri uri,
      {User? user, QueryType? queryType, String? token}) async {
    http.Response response = await http.get(
      uri,
      headers: _buildHeaders(uri,
          isTestModeActive:
              FolksonomyAPIConfiguration.getQueryType(queryType) ==
                      QueryType.PROD
                  ? false
                  : true,
          token: token),
    );

    return response;
  }

  /// Send a http post request to the specified uri.
  /// The data / body of the request has to be provided as map. (key, value)
  /// The result of the request will be returned as string.
  Future<http.Response> doPostRequest(Uri uri, Map<String, dynamic> body,
      {QueryType? queryType, String? token}) async {
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var headear = _buildHeaders(uri,
        isTestModeActive:
            FolksonomyAPIConfiguration.getQueryType(queryType) == QueryType.PROD
                ? false
                : true,
        token: token);
    http.Response response = await http.post(uri,
        headers: headear,
        body: headear!['Content-Type'] == 'application/json' ? jsonBody : body,
        encoding: encoding);
    print(jsonBody);
    return response;
  }

  Map<String, String>? _buildHeaders(Uri uri,
      {bool isTestModeActive = false, String? token}) {
    Map<String, String>? headers = {};

    headers.addAll({
      'Accept': 'application/json',
      'Content-Type': uri.path == '/product'
          ? 'application/json'
          : 'application/x-www-form-urlencoded'
      // 'UserAgent':
      //     FolksonomyAPIConfiguration.userAgent?.toValueString() ?? USER_AGENT,
      // 'From': FolksonomyAPIConfiguration.getUser()?.toValueString() ?? FROM,
    });
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    if (isTestModeActive) {
      var token = 'Basic ' + base64Encode(utf8.encode('off:off'));
      headers.addAll({'authorization': token});
    }
    return headers;
  }
}
