import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/four_images_offer.dart';
import '../../../../domain/usecase/admin_usecase.dart';

part 'admin_four_image_offer_state.dart';

@Injectable()
class AdminFourImageOfferCubit extends Cubit<AdminFourImageOfferState> {
  final AdminUseCase _adminUseCase;
  AdminFourImageOfferCubit(this._adminUseCase)
      : super(AdminFourImageOfferInitialS());

  Future<void> addFourImagesOffer({
    required String title,
    required List<File> images,
    required String label1,
    required String label2,
    required String label3,
    required String label4,
    required String category,
  }) async {
    try {
      emit(AdminFourImageOfferLoadingS());
      List<String> labels = [label1, label2, label3, label4];

      final either = await _adminUseCase.adminAddFourImagesOffer(
          title: title, images: images, labels: labels, category: category);
      either.fold((l) {
        emit(AdminFourImageOfferErrorS(errorString: l.message));
      }, (r) {
        emit(AdminAddFourImageOfferSuccessS());
      },);
    } catch (e) {
      emit(AdminFourImageOfferErrorS(errorString: e.toString()));
    }
  }

  Future<void> adminGetFourImagesOffer({required bool isUser}) async {
    try {
      emit(AdminFourImageOfferLoadingS());

      List<FourImagesOffer> fourImagesOfferList = [];
      List<FourImagesOffer> tempFourImagesOfferList = [];

      final either = await _adminUseCase.adminGetFourImagesOffer();
      either.fold((l) {
        emit(AdminFourImageOfferErrorS(errorString: l.message));
      }, (r) {
        tempFourImagesOfferList = r;

        if (isUser) {
          // tempFourImagesOfferList.shuffle();
          fourImagesOfferList = tempFourImagesOfferList;
        } else {
          fourImagesOfferList = tempFourImagesOfferList.reversed.toList();
        }

        emit(AdminGetFourImageOfferSuccessS(
            fourImagesOfferList: fourImagesOfferList));
      },);
    } catch (e) {
      emit(AdminFourImageOfferErrorS(errorString: e.toString()));
    }
  }

  Future<void> adminDeleteFourImagesOffer({required String offerId}) async {
    try {
      List<FourImagesOffer> fourImagesOfferList;
      List<FourImagesOffer> tempFourImagesOfferList;

      final either = await _adminUseCase.adminDeleteFourImagesOffer(offerId: offerId);
      either.fold((l) {
        emit(AdminFourImageOfferErrorS(errorString: l.message));

      },(r) {
        tempFourImagesOfferList = r;

        fourImagesOfferList = tempFourImagesOfferList.reversed.toList();

        emit(AdminGetFourImageOfferSuccessS(
            fourImagesOfferList: fourImagesOfferList));
      },);
    } catch (e) {
      emit(AdminFourImageOfferErrorS(errorString: e.toString()));
    }
  }
}
