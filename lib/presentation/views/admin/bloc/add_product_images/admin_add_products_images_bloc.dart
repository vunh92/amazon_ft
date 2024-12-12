import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/repository/admin_repository.dart';

part 'admin_add_products_images_event.dart';
part 'admin_add_products_images_state.dart';

@Injectable()
class AdminAddProductsImagesBloc
    extends Bloc<AdminAddProductsImagesEvent, AdminAddProductsImagesState> {
  final AdminRepository _adminRepository;
  AdminAddProductsImagesBloc(this._adminRepository)
      : super(AdminAddProductsInitialS()) {
    on<SelectImagesPressedE>(_onSelectImagesPressedHandler);
    on<ClearImagesPressedE>(_onClearImagesPressedEHandler);
  }

  void _onSelectImagesPressedHandler(event, emit) async {
    try {
      List<File> imagesList = [];

      var images = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (images != null || images!.files.isNotEmpty) {
        for (int i = 0; i < images.files.length; i++) {
          imagesList.add(File(images.files[i].path!));
        }
      }

      emit(AdminAddProductsImagesSelectedS(imagesList: imagesList));
    } catch (e) {
      emit(AdminAddProductsErrorS(errorString: e.toString()));
    }
  }

  List<File>? get imagesList {
    if (state is AdminAddProductsImagesSelectedS) {
      return (state as AdminAddProductsImagesSelectedS).imagesList;
    } else {
      return null;
    }
  }

  void _onClearImagesPressedEHandler(event, emit) {
    emit(AdminAddProductsClearImagesS());
  }
}
