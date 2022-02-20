import 'package:demo_app/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ) );
}


