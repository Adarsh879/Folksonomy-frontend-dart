import 'QueryType.dart';
import 'configuration/folksonomyApiConfiguration.dart';

///Helper class for constructing urls with the in the [FolksonomyAPIConfiguration] specified settings
class UriHelper {
  UriHelper._();

  ///Returns a OFF-Folksonomy uri with the in the [FolksonomyAPIConfiguration] specified settings
  static Uri getFolksonomyUri({
    required final String path,
    final Map<String, dynamic>? queryParameters,
    final QueryType? queryType,
  }) =>
      Uri(
        scheme: FolksonomyAPIConfiguration.uriScheme,
        host:
            FolksonomyAPIConfiguration.getQueryType(queryType) == QueryType.PROD
                ? FolksonomyAPIConfiguration.uriProdHostFolksonomy
                : FolksonomyAPIConfiguration.uriTestHostFolksonomy,
        path: path,
        queryParameters: queryParameters,
      );
}
