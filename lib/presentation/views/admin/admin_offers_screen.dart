import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/common/common.dart';
import '../home/bloc/admin_four_image_offer_cubit.dart';
import 'admin_home_screen.dart';
import 'widgets/admin_four_images_offer.dart';

class AdminOffersScreen extends StatelessWidget {
  const AdminOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<AdminFourImageOfferCubit>()
        .adminGetFourImagesOffer(isUser: false);
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () =>
            context.pushNamed(AppRouteConstants.adminAddOfferScreen.name),
        toolTip: 'Add a offer',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: BlocConsumer<AdminFourImageOfferCubit, AdminFourImageOfferState>(
          listener: (context, state) {
            if (state is AdminFourImageOfferErrorS) {
              showSnackBar(context, state.errorString);
            }
          },
          builder: (context, state) {
            if (state is AdminGetFourImageOfferSuccessS) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Total ${state.fourImagesOfferList.length} Offers',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.fourImagesOfferList.length,
                      itemBuilder: ((context, index) {
                        final offer = state.fourImagesOfferList[index];

                        return AdminFourImagesOffer(
                          offerId: offer.id!,
                          title: offer.title,
                          category: offer.category,
                          images: offer.images,
                          labels: offer.labels,
                        );
                      })),
                ],
              );
            } else {
              context
                  .read<AdminFourImageOfferCubit>()
                  .adminGetFourImagesOffer(isUser: false);
              return SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// AdminFourImageOfferCubit