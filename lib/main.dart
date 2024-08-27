import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app.dart';
import 'package:tic_tac_toe/firebase_options.dart';
import 'package:tic_tac_toe/src/core/utils/app_info.dart';

import 'src/core/data/data_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedManager().init();
  await AppInfo.load();
  runApp(const App());
}
