import 'package:flutter/material.dart';
import 'package:neo_application/pages/home_page/home_page.dart';
import 'package:neo_application/pages/login_page/login_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:neo_application/pages/provider/drawer_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DrawerProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage()),
    );
  }
}
