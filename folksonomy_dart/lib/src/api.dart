import 'dart:convert';

import 'package:folksonomy_dart/src/model/KeyStats.dart';
import 'package:folksonomy_dart/src/model/ProductList.dart';
import 'package:folksonomy_dart/src/model/product_stats.dart';
import 'package:folksonomy_dart/src/utils/QueryType.dart';
import 'package:folksonomy_dart/src/utils/httpHelper.dart';
import 'package:folksonomy_dart/src/utils/uriHelper.dart';
import 'package:folksonomy_dart/src/utils/validate.dart';
import 'package:http/http.dart';

import 'model/product_tag.dart';
import 'model/user.dart';

class FolksonomyAPIClient {
  FolksonomyAPIClient._();

  static Future<Map<String, dynamic>> authenticate(
    String user,
    String password,
    final QueryType? queryType,
  ) async {
    final Map<String, String> body = <String, String>{};
    body['username'] = user;
    body['password'] = password;
    final Response response = await HttpHelper().doPostRequest(
      UriHelper.getFolksonomyUri(
        path: '/auth',
        queryType: queryType,
      ),
      body,
      queryType: queryType,
    );
    Validate.checkResponse(response);
    print(jsonDecode(response.body));
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Returns the list of tag keys with statistics.
  static Future<Map<String, KeyStats>> getKeys({
    final QueryType? queryType,
  }) async {
    final Map<String, String> parameters = <String, String>{};
    /* TODO "The keys list can be restricted to private tags from some owner"
    if (owner != null) {
      parameters['owner'] = owner;
    }
     */
    final Response response = await HttpHelper().doGetRequest(
      UriHelper.getFolksonomyUri(
        path: 'keys',
        queryParameters: parameters,
        queryType: queryType,
      ),
      queryType: queryType,
    );
    Validate.checkResponse(response);
    final Map<String, KeyStats> result = <String, KeyStats>{};
    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    for (var element in json) {
      final KeyStats item = KeyStats.fromJson(element);
      result[item.key] = item;
    }
    return result;
  }

  /// adds new product key-value tag
  /// if owner parameter is passed it adds the tag as private
  static Future<void> addProductTag(
      String barcode, String key, String value, String token,
      {QueryType? queryType, String? owner}) async {
    ProductTag productTag;
    if (Validate.isPrivate(owner, token)) {
      productTag = ProductTag(
          barcode: barcode,
          key: key,
          value: value,
          owner: owner!,
          version: 1,
          editor: owner,
          lastEdit: DateTime.now(),
          comment: '');
    } else {
      productTag = ProductTag(
          barcode: barcode,
          key: key,
          value: value,
          owner: '',
          version: 1,
          editor: '',
          lastEdit: DateTime.now(),
          comment: '');
    }
    print(productTag);
    /* TODO
    chechToken()
    */
    final Response response = await HttpHelper().doPostRequest(
        UriHelper.getFolksonomyUri(
          path: '/product',
          queryType: queryType,
        ),
        productTag.toJson(),
        queryType: queryType,
        token: token);
    Validate.checkResponse(response);
    print(response.body);
  }

  /// Returns all the [ProductStats], with an optional filter.
  ///
  /// The result can be filtered with that [key], or with [key] = [value].
  static Future<List<ProductStats>> getProductStats(
      {final String? key,
      final String? value,
      final QueryType? queryType,
      String? owner,
      String? token}) async {
    final Map<String, String> parameters = <String, String>{};
    if (key == null && value != null) {
      throw Exception(
          'Does a value have a meaning without its key? I don\'t think so.');
    }
    if (key != null) {
      parameters['k'] = key;
    }
    if (value != null) {
      parameters['v'] = value;
    }
    if (Validate.isPrivate(owner, token)) {
      parameters['owner'] = owner!;
    }
    final Response response = await HttpHelper().doGetRequest(
      UriHelper.getFolksonomyUri(
        path: 'products/stats',
        queryParameters: parameters,
        queryType: queryType,
      ),
      token: token,
      queryType: queryType,
    );
    Validate.checkResponse(response);
    final List<ProductStats> result = <ProductStats>[];
    if (response.body == 'null') {
      // not found
      return result;
    }
    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    for (var element in json) {
      result.add(ProductStats.fromJson(element));
    }
    return result;
  }

  /// Returns all the products with that [key].
  ///
  /// The key of the returned map is the barcode, the value is the tag value.
  static Future<Map<String, String>> getProducts(
      {required final String key,
      final String? value,
      final QueryType? queryType,
      String? owner,
      String? token}) async {
    final Map<String, String> parameters = <String, String>{};
    parameters['k'] = key;
    if (value != null) {
      parameters['v'] = value;
    }
    if (Validate.isPrivate(owner, token)) {
      parameters['owner'] = owner!;
    }
    final Response response = await HttpHelper().doGetRequest(
      UriHelper.getFolksonomyUri(
        path: 'products',
        queryParameters: parameters,
        queryType: queryType,
      ),
      token: token,
      queryType: queryType,
    );
    Validate.checkResponse(response);
    final Map<String, String> result = <String, String>{};
    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    for (var element in json) {
      final ProductList productList = ProductList.fromJson(element);
      if (productList.key != key) {
        throw Exception('Unexpected key: ${productList.key}');
      }
      result[productList.barcode] = productList.value;
    }
    return result;
  }

  /// Returns all the [ProductTag]s for this product
  ///
  /// The key of the returned map is the tag key.
  static Future<Map<String, ProductTag>> getProductTags(
      {required final String barcode,
      final QueryType? queryType,
      final String? owner,
      final String? token}) async {
    final Map<String, String> parameters = <String, String>{};
    if (Validate.isPrivate(owner, token)) {
      parameters['owner'] = owner!;
    }
    final Response response = await HttpHelper().doGetRequest(
      UriHelper.getFolksonomyUri(
        path: 'product/$barcode',
        queryParameters: parameters,
        queryType: queryType,
      ),
      token: token,
      queryType: queryType,
    );
    Validate.checkResponse(response);
    final Map<String, ProductTag> result = <String, ProductTag>{};
    if (response.body == 'null') {
      // not found
      return result;
    }
    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    for (var element in json) {
      final ProductTag productTag = ProductTag.fromJson(element);
      result[productTag.key] = productTag;
    }
    return result;
  }
}
