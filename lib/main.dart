import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task/provider/auth.dart';
import 'package:task/provider/layout_controller.dart';
import 'package:task/sign_in.dart';
import 'package:task/sign_up.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<LayoutController>(
            create: (_) => LayoutController()),
        ChangeNotifierProvider<User>(
            create: (_) => User(uid: '', displayName: '', photoUrl: '')),
        Provider<AuthBase>(
          create: (context) => Auth(),

        ),
      ],
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      routes: {
        '/SignUp':(_)=>SignUp()

      },
    );

  }
}

