import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zylentrix/viewsmodels/post_viewmodel.dart';

import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PostViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
