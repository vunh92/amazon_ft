import 'dart:convert';
import 'dart:io';
import 'package:amazon_ft/app/common/common.dart';
import 'package:amazon_ft/domain/repository/admin_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart' hide Order;

import '../../domain/model/four_images_offer.dart';
import '../../domain/model/order.dart';
import '../../domain/model/product.dart';
import '../../domain/model/sales.dart';
import '../data_source/api/admin_api.dart';

@Injectable(as: AdminRepository)
class AdminRepositoryImpl extends AdminRepository {
  late final AdminApi _adminApi;

  AdminRepositoryImpl(this._adminApi);

  @override
  Future<Either<Failure, List<String>>> uploadImages({
    String? name,
    String? title,
    required String category,
    required List<File> images,
    bool isOffer = false,
  }) async {
    return Left(Failure(1, 'Fail'));
    // try {
    //   List<String> imageUrls = [];
    //   String folder;
    //   final String cloudinaryCloudName = dotenv.env['CLOUDINARY_CLOUDNAME']!;
    //   final String cloudinaryUploadPreset =
    //       dotenv.env['CLOUDINARY_UPLOADPRESET']!;
    //
    //   final cloudinary = CloudinaryPublic(
    //       cloudinaryCloudName, cloudinaryUploadPreset,
    //       cache: false);
    //
    //   if (isOffer) {
    //     String folderName = formatFolderName(title!);
    //     folder = 'Offers/Four Images Offers/$category/$folderName';
    //   } else {
    //     String folderName = formatFolderName(name!);
    //
    //     folder = 'products/$category/$folderName';
    //   }
    //
    //   for (int i = 0; i < images.length; i++) {
    //     CloudinaryResponse res = await cloudinary.uploadFile(
    //         CloudinaryFile.fromFile(images[i].path,
    //             resourceType: CloudinaryResourceType.Image, folder: folder));
    //
    //     imageUrls.add(res.secureUrl);
    //   }
    //
    //   return imageUrls;
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  @override
  Future<Either<Failure, void>> adminAddProduct({
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      List<String> imageUrls;

      imageUrls =
          (await uploadImages(name: name, category: category, images: images)) as List<String>;

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await _adminApi.adminAddProduct(product: product);

      if (res.statusCode != 200) {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
      return const Right(Function);
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> adminAddFourImagesOffer({
    required String title,
    required List<File> images,
    required List<String> labels,
    required String category,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(Function);
      List<String> imageUrls;

      imageUrls = (await uploadImages(
          title: title, category: category, images: images, isOffer: true)) as List<String>;

      FourImagesOffer fourImagesOffer = FourImagesOffer(
          title: title, images: imageUrls, labels: labels, category: category);

      http.Response res =
          await _adminApi.addFourImagesOffer(fourImagesOffer: fourImagesOffer);

      if (res.statusCode != 200) {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
      return const Right(Function);
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FourImagesOffer>>> adminGetFourImagesOffer() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(Constants.mockFourImagesOffer);
      List<FourImagesOffer> fourImagesOfferList = [];
      http.Response res = await _adminApi.adminGetFourImagesOffer();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          fourImagesOfferList.add(
            FourImagesOffer.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return Right(fourImagesOfferList);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FourImagesOffer>>> adminDeleteFourImagesOffer(
      {required String offerId}) async {
    try {
      List<FourImagesOffer> fourImagesOfferList = [];
      http.Response res =
          await _adminApi.adminDeleteFourImagesOffer(offerId: offerId);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          fourImagesOfferList.add(
            FourImagesOffer.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return Right(fourImagesOfferList);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> adminGetCategoryProducts(
      {required String category}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return Right(
          Constants.mockCategoryProducts.where(
                (element) => element.category == category,).toList()
      );
      List<Product> categoryProducts = [];

      http.Response res =
          await _adminApi.adminGetCategoryProducts(category: category);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          categoryProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return Right(categoryProducts);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> adminDeleteProduct({required Product product}) async {
    try {
      http.Response res = await _adminApi.adminDeleteProduct(product: product);

      if (res.statusCode != 200) {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
      return const Right(Function);
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> adminGetOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return Right(Constants.mockOrderList);
      List<Order> ordersList = [];
      http.Response res = await _adminApi.adminGetOrders();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          ordersList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return Right(ordersList);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> adminChangeOrderStatus(
      {required String orderId, required int status}) async {
    try {
      int resStatus;
      http.Response res = await _adminApi.adminChangeOrderStatus(
          status: status, orderId: orderId);

      if (res.statusCode == 200) {
        resStatus = jsonDecode(res.body);
        return Right(resStatus);
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> adminGetAnalytics() async {
    try {
      await Future.delayed(const Duration(milliseconds: 700));
      return const Right({
        'sales': Constants.mockAnalytics,
        'totalEarnings': 100,
      });
      List<Sales> sales;
      int totalEarnings;

      http.Response res = await _adminApi.adminGetAnalytics();

      if (res.statusCode == 200) {
        var resDecoded = jsonDecode(res.body);

        totalEarnings = resDecoded['totalEarnings'];

        sales = [
          Sales('Mobiles', resDecoded['mobileEarnings'] ?? 0),
          Sales('Fashion', resDecoded['fashionEarnings'] ?? 0),
          Sales('Electronics', resDecoded['electronicsEarnings'] ?? 0),
          Sales('Home', resDecoded['homeEarnings'] ?? 0),
          Sales('Beauty', resDecoded['beautyEarnings'] ?? 0),
          Sales('Appliances', resDecoded['appliancesEarnings'] ?? 0),
          Sales('Grocery', resDecoded['groceryEarnings'] ?? 0),
          Sales('Books', resDecoded['booksEarnings'] ?? 0),
          Sales('Essentials', resDecoded['essentialsEarnings'] ?? 0),
        ];

        return Right({
          'sales': sales,
          'totalEarnings': totalEarnings,
        });
      } else {
        return Left(Failure(res.statusCode, jsonDecode(res.body)['msg']));
      }
    } catch (e) {
      return Left(Failure(e.hashCode, e.toString()));
    }
  }

}
