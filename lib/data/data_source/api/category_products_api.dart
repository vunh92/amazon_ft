import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../app/common/common.dart';
import '../../network/api_url.dart';

@Injectable()
class CategoryProductsApi {
  final client = http.Client();

  Future<http.Response> fetchCategoryProducts(String category) async {
    String token = await getToken();

    try {
      http.Response res = await client
          .get(Uri.parse('$fetchCategoryProductsUri$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
