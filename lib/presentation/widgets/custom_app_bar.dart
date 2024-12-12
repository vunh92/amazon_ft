import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/common/common.dart';
import '../../app/config/router/app_route_constants.dart';
import 'search_text_form_field.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: Constants.appBarGradient),
      ),
      title: SearchTextFormField(onTapSearchField: (String query) {
        context.pushNamed(AppRouteConstants.searchScreenRoute.name,
            pathParameters: {'searchQuery': query});
      }),
    );
  }
}
