import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_widget.dart';
import 'app/models/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: AppWidget(),
    ),
  );
}

