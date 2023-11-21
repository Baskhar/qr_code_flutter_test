import 'package:flutter/material.dart';
import 'package:qr_code_flutter/app/screens/auth/login_screen.dart';
import 'package:qr_code_flutter/app/screens/auth/register_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
'/':(_) => LoginScreen(),
'/register':(_) => RegisterScreen(),
      },
    );
  }
}
