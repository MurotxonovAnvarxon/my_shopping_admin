import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> fetchUserOrder() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool isRegistered = shared.getBool("AUTH") ?? false;
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, isRegistered ? "home" : "login");
    });
  }

  @override
  void initState() {
    fetchUserOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          Icon(Icons.shopping_cart,size: 56,color: Colors.black,)
        ],
      ),
    );
  }
}
