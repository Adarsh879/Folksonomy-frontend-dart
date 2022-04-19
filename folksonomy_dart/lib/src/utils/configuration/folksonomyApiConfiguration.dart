import 'package:folksonomy_dart/src/model/user.dart';
import 'package:folksonomy_dart/src/utils/QueryType.dart';

import '../../model/userAgent.dart';

class FolksonomyAPIConfiguration {
  FolksonomyAPIConfiguration._();

  ///Defines a global userAgent to tell the backend the source of the request.
  static UserAgent? userAgent;

  ///Defines a global uuid to tell the backend the source of the request.
  static String? uuid;

  ///Defines a global user to avoid adding it to every request
  static User? globalUser;

  ///change the uriScheme of the requests
  static String uriScheme = 'https';

  ///Uri host of the Folksonomy requests to the backend, modify this to direct the request to a self-hosted instance.
  static String uriProdHostFolksonomy = 'api.folksonomy.openfoodfacts.org';

  static String uriTestHostFolksonomy =
      'api.folksonomy.openfoodfacts.net'; // TODO does not work

  ///Changes whether the requests sent by this package to the test or main server.
  static QueryType globalQueryType = QueryType.PROD;

  ///Returns the [QueryType] to use, using a default value
  static QueryType getQueryType(final QueryType? queryType) =>
      queryType ?? globalQueryType;

  static User? getUser(final User? user) => user ?? globalUser;
}
