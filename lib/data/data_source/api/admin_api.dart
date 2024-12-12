import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../app/common/common.dart';
import '../../../domain/model/four_images_offer.dart';
import '../../../domain/model/product.dart';
import '../../network/api_url.dart';

@Injectable()
class AdminApi {
  final client = http.Client();

  Future<http.Response> adminGetCategoryProducts(
      {required String category}) async {
    final String token = await getToken();
    try {
      http.Response res = await client
          .get(Uri.parse('$adminGetCategoryProductsUri/$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminDeleteProduct({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(Uri.parse(adminDeleteProductUri),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode({"id": product.id}));

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminGetOrders() async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(adminGetOrdersUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminChangeOrderStatus(
      {required int status, required String orderId}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(adminChangeOrderStatusUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {'id': orderId, 'status': status},
        ),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminGetAnalytics() async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(adminGetAnalyticsUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminAddProduct({required Product product}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(Uri.parse(adminAddProductsUri),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: product.toJson());
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> addFourImagesOffer(
      {required FourImagesOffer fourImagesOffer}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.post(
        Uri.parse(adminAddFourImagesOfferUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: fourImagesOffer.toJson(),
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminGetFourImagesOffer() async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse(adminGetFourImagesOfferUri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> adminDeleteFourImagesOffer(
      {required String offerId}) async {
    final String token = await getToken();
    try {
      http.Response res = await client.get(
        Uri.parse('$adminDeleteFourImagesOfferUri/$offerId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
