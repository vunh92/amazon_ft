import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/constants.dart';
import '../../../../app/config/router/app_route_constants.dart';
import 'single_top_category_item.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(gradient: Constants.goldenGradient),
      child: Center(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Constants.categoryImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                      AppRouteConstants.categoryproductsScreenRoute.name,
                      pathParameters: {
                        'category': Constants.categoryImages[index]['title']!
                      });
                },
                child: SingleTopCategoryItem(
                  title: Constants.categoryImages[index]['title']!,
                  image: Constants.categoryImages[index]['image']!,
                ),
              );
            }),
      ),
    );
  }
}
