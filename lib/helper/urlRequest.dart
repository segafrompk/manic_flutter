import 'package:http/http.dart' as http;
import 'constants.dart' as constants;

Future<http.Response> fetchFromApiUrlPath(String urlPath) {
  return http.get(Uri.https(constants.apiAddress, urlPath));
}
