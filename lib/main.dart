import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'app/di.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  // HydratedBloc.storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp());
  // runZonedGuarded(() async {
  //   runApp(const MyApp());
  // }, (error, stack) {
  //   log("App Error with: $error");
  //   log("App Error stack: $stack");
  // },
  // );
}