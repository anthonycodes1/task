import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:task/sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final auth= Provider.of<AuthBase>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          TextButton(
            onPressed: () async {
              await auth.signOut();
              Get.offAll(() => SignIn());
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: FirebaseAuth.instance.currentUser != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                Text(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                if (FirebaseAuth.instance.currentUser!.photoURL != null)
                  Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL.toString(),
                    height: 100,
                    width: 100,
                  ),

              ],
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

