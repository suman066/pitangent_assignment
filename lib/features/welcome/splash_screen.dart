import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/common/helper/navigation_helper.dart';

import '../../core/common/constants/common_constants.dart';








class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? otpVerified = false;
  bool? registered = false;
  String? phoneNumber = '';
  double screenHeight=0;
  double screenWidth=0;
  static const kWhite = Color(0xFFFCFCFC);
  String location = "";
  String currentLatitude = "";
  String currentLongitude = "";
  String currentaddress = "";
  bool locCheckPass=true;







  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(

        statusBarColor: const Color(0xffFFFFFF),/* set Status bar color in Android devices. */

        statusBarIconBrightness: Brightness.dark,/* set Status bar icons color in Android devices.*/

        statusBarBrightness: Brightness.dark)/* set Status bar icon color in iOS. */
    );
    screenHeight= MediaQuery.of(context).size.height;
    screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body:  Center(
        child:
        SvgPicture.asset("assets/images/design.svg",
          color: Colors.cyan,
          width: 200.0,
        ),
      ),
    );

  }
  getPreferences() async{

    final prefs = await SharedPreferences.getInstance();
    otpVerified = prefs.getBool('otpVerified');
    registered = prefs.getBool('registered');
    phoneNumber = prefs.getString('phoneNumber');

    if(phoneNumber!=null)
    {
      number = phoneNumber!;
    }

    if(otpVerified == true)
    {
      /*Timer(
          const Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()
              )
          )


      );*/
      Timer(
          const Duration(seconds: 3),
              () =>CustomNavigationHelper.router.replace(CustomNavigationHelper.dashboardPath)


      );
    }
    else{

      Timer(
          const Duration(seconds: 3),
              () =>CustomNavigationHelper.router.replace(CustomNavigationHelper.loginPath)


      );


    }

  }

  @override
  void dispose() {
    super.dispose();
  }
}
