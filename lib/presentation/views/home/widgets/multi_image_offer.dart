import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/common.dart';

class MultiImageOffer extends StatelessWidget {
  const MultiImageOffer({
    super.key,
    required this.title,
    required this.images,
    required this.labels,
    required this.category,
  });

  final String title;
  final List<String> labels;
  final List<String> images;
  final String category;

  @override
  Widget build(BuildContext context) {
    void goToCategoryDealsScreen() {
      context.pushNamed(AppRouteConstants.categoryproductsScreenRoute.name,
          pathParameters: {'category': category});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          // width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 460,
                child: GridView.builder(
                  itemCount: images.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 230, crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () => goToCategoryDealsScreen(),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: images[index],
                                  fit: BoxFit.fill,
                                  width: MediaQuery.sizeOf(context).width,
                                  height: MediaQuery.sizeOf(context).height,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                labels[index],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 8),
                child: GestureDetector(
                  onTap: () => goToCategoryDealsScreen(),
                  child: Text(
                    'See all offers',
                    style: TextStyle(color: Constants.selectedNavBarColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
