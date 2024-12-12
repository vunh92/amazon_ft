import 'package:flutter/material.dart';

import '../../../../domain/model/product.dart';
import '../../../widgets/stars.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({
    super.key,
    required this.averageRating,
    required this.product,
  });

  final double averageRating;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer ratings',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Stars(
              rating: averageRating,
              size: 22,
            ),
            const SizedBox(width: 5),
            Text('${averageRating.toStringAsFixed(1)} out of 5',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87)),
            const SizedBox(width: 6),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${product.rating?.length ?? 0} global ratings',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
