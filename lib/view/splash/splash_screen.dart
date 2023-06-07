import 'package:flutter/material.dart';
import 'package:social_media/res/color.dart';

import '../../res/fonts.dart';
import '../../view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    services.isLogIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Image(image: AssetImage('assets/images/3beez.jpeg')),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Center(
                child: Text(
              '3Beez Tech',
              style: TextStyle(
                  fontFamily: AppFonts.sfProDisplayBold,
                  fontSize: 30,
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w700),
            )),
          )
        ],
      )),
    );
  }
}
