import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/wish_list/wish_list_cubit.dart';
import '../../../app/common/common.dart';
import '../../../domain/model/product.dart';
import '../../widgets/custom_app_bar.dart';
import 'widgets/single_wish_list_product.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Wish List',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              BlocConsumer<WishListCubit, WishListState>(
                listener: (context, state) {
                  if (state is GetWishListErrorState) {
                    showSnackBar(context, state.errorString);
                  }
                },
                builder: (context, state) {
                  if (state is GetWishListLoadingState) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height / 1.4,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is GetWishListSuccessState) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.wishList.length,
                        itemBuilder: ((context, index) {
                          Product product = state.wishList[index];
                          double averageRating = state.averageRatingList[index];

                          return SingleWishListProduct(
                            product: product,
                            deliveryDate: getDeliveryDate(),
                            averageRating: averageRating,
                          );
                        }));
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
