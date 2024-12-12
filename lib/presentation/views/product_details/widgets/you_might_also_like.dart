import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/common.dart';
import '../../../../domain/model/product.dart';
import '../../../widgets/you_might_also_like_single.dart';
import '../../category_products/bloc/fetch_category_products_bloc.dart';

class YouMightAlsoLike extends StatelessWidget {
  const YouMightAlsoLike({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You might also like',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: BlocConsumer<FetchCategoryProductsBloc,
              FetchCategoryProductsState>(
            listener: (context, state) {
              if (state is FetchCategoryProductsErrorS) {
                showSnackBar(context, state.errorString);
              }
            },
            builder: (context, state) {
              if (state is FetchCategoryProductsLoadingS) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchCategoryProductsSuccessS) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.productList.length,
                    itemBuilder: ((context, index) {
                      Product product = state.productList[index];
                      double averageRating = state.averageRatingList[index];

                      return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                                AppRouteConstants
                                    .productDetailsScreenRoute.name,
                                extra: {
                                  "product": product,
                                  "deliveryDate": getDeliveryDate(),
                                });
                          },
                          child: YouMightAlsoLikeSingle(
                              averageRating: averageRating, product: product));
                    }));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
