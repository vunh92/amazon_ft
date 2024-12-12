import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/common/common.dart';
import '../model/four_images_offer.dart';
import '../repository/admin_repository.dart';

@Injectable()
class AdminUseCase {
  late final AdminRepository _adminRepository;

  AdminUseCase(this._adminRepository);

  Future<Either<Failure, List<String>>> uploadImages({
    String? name,
    String? title,
    required String category,
    required List<File> images,
    bool isOffer = false,
  }) async {
    return await _adminRepository.uploadImages(
        category: category, images: images);
  }

  Future<Either<Failure, void>> adminAddFourImagesOffer({
    required String title,
    required List<File> images,
    required List<String> labels,
    required String category,
  }) async {
    return await _adminRepository.adminAddFourImagesOffer(
        title: title, images: images, labels: labels, category: category);
  }

  Future<Either<Failure, List<FourImagesOffer>>> adminGetFourImagesOffer() async {
    return await _adminRepository.adminGetFourImagesOffer();
  }

  Future<Either<Failure, List<FourImagesOffer>>> adminDeleteFourImagesOffer(
      {required String offerId}) async {
    return await _adminRepository.adminDeleteFourImagesOffer(offerId: offerId);
  }
}
