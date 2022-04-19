import 'package:http/http.dart' as http;

class Validate {
  Validate._();

  /// Throws a detailed exception if relevant. Does nothing if [response] is OK.
  static void checkResponse(final http.Response response) {
    if (response.statusCode != 200) {
      print(response.body);
      // TODO have a look at ValidationError in https://api.folksonomy.openfoodfacts.org/docs
      throw Exception('Wrong status code: ${response.statusCode}');
    }
  }

  static bool isPrivate(String? owner, String? token) {
    if (owner == null) {
      return false;
    }
    if (token == null) {
      throw Exception('Authorization Token required');
    }
    return true;
  }
}
