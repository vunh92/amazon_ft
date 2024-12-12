import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/user/user_cubit.dart';
import '../../../../app/common/common.dart';

class NameBar extends StatelessWidget {
  const NameBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff92DDE6),
                Color(0xffA6E6CE),
              ]),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserSuccessState) {
                  String name = capitalizeFirstLetter(string: state.user.name);
                  return Text(
                    name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ));
  }
}
