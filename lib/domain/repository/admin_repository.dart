import 'dart:io';

import 'package:amazon_ft/app/common/common.dart';
import 'package:dartz/dartz.dart' hide Order;

import '../model/four_images_offer.dart';
import '../model/order.dart';
import '../model/product.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<String>>> uploadImages({
    String? name,
    String? title,
    required String category,
    required List<File> images,
    bool isOffer = false,
  });

  Future<Either<Failure, void>> adminAddProduct({
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  });

  Future<Either<Failure, void>> adminAddFourImagesOffer({
    required String title,
    required List<File> images,
    required List<String> labels,
    required String category,
  });

  Future<Either<Failure, List<FourImagesOffer>>> adminGetFourImagesOffer();

  Future<Either<Failure, List<FourImagesOffer>>> adminDeleteFourImagesOffer(
      {required String offerId});

  Future<Either<Failure, List<Product>>> adminGetCategoryProducts({required String category});

  Future<Either<Failure, void>> adminDeleteProduct({required Product product});

  Future<Either<Failure, List<Order>>> adminGetOrders();

  Future<Either<Failure, int>> adminChangeOrderStatus(
      {required String orderId, required int status});

  Future<Either<Failure, Map<String, dynamic>>> adminGetAnalytics();
}
