import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/helper/navigation_helper.dart';
import '../../../core/common/constants/common_constants.dart';




class OTPScreen extends StatefulWidget {

  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;


  @override
  State<OTPScreen> createState() => _OTPScreenState(phoneNumber);
}

class _OTPScreenState extends State<OTPScreen> {
  var onTapRecognizer;
  String phone_number="";
  bool isButtonActive = false;
  _OTPScreenState(String phoneNumber){
    this.phone_number=phoneNumber;
    print('+91$phone_number');
  }
  late FirebaseAuth _auth;
  late String codeVerificationId;
  int codeResendToken=0;
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 30);
  @override
  void initState() {
    super.initState();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        resetTimer();
        startTimer();
        otpVerify(context,token: codeResendToken);
      };
    startTimer();
    _auth = FirebaseAuth.instance;
    otpVerify(context);
  }
  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: 30));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  Future<void> otpVerify(BuildContext context,{int? token}) async {
    // print("dhuke ge6e");
    print("OTP Sent");
    print("here 1st codeResend token : $token");

    _auth.verifyPhoneNumber(
        forceResendingToken: token,
        phoneNumber: "+91${widget.phoneNumber}",
        timeout: Duration(seconds: 30),
        verificationCompleted: (AuthCredential credential) async {
          User? user = (await _auth.signInWithCredential(credential)).user;
          if (user != null) {
            print("login success via firebase otp auto");
            _login();

          }
        },
        verificationFailed: (FirebaseAuthException exception) {
          print("error di6666eee $exception");
          print("error di66e otp te");
          if(exception.message!.contains("interrupted connection or unreachable host")){
            Fluttertoast.showToast(
                msg: "Oops! Please Check Your Internet Connectivity.",
                fontSize: 16,
                backgroundColor: Colors.orange[100],
                textColor: darkThemeBlue,
                toastLength: Toast.LENGTH_LONG);
          }else if(exception.message!.contains("The format of the phone number provided is incorrect")){
            Fluttertoast.showToast(
                msg: "Please Enter a Correct and New Phone Number.",
                fontSize: 16,
                backgroundColor: Colors.orange[100],
                textColor: darkThemeBlue,
                toastLength: Toast.LENGTH_LONG);
          }else{
            Fluttertoast.showToast(
                msg: "Please Try Again With a New Phone Number",
                fontSize: 16,
                backgroundColor: Colors.orange[100],
                textColor: darkThemeBlue,
                toastLength: Toast.LENGTH_LONG);
          }

        },
        codeSent: (String verificationId, int? forceResendingToken) {
          final code = currentText.trim();
          codeVerificationId = verificationId;
          codeResendToken=forceResendingToken!;
          print("here is codeResend token : $codeResendToken");
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }
  otpVerification() async{
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: codeVerificationId, smsCode: currentText);
      User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        print("successfully verify manually");
        _login();
      } else {
        print("Error");
        Fluttertoast.showToast(
            msg: "Please Try Again!",
            fontSize: 16,
            backgroundColor: Colors.orange[100],
            textColor: darkThemeBlue,
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (PlatformException) {
      print("keno dibi ex $PlatformException");
      if(PlatformException.toString().contains("The sms code has expired")){
        setState(() {
          hasError = true;
          isButtonActive=true;
        });
        Fluttertoast.showToast(
            msg: "OTP code has been expired",
            fontSize: 16,
            backgroundColor: Colors.orange[100],
            textColor: darkThemeBlue,
            toastLength: Toast.LENGTH_LONG);
      }else if(PlatformException.toString().contains("The sms verification code used to create the phone auth credential is invalid")){
        setState(() {
          hasError = true;
          isButtonActive=true;
        });
        Fluttertoast.showToast(
            msg: "Please Enter Correct OTP",
            fontSize: 16,
            backgroundColor: Colors.orange[100],
            textColor: darkThemeBlue,
            toastLength: Toast.LENGTH_LONG);
      }else{
        setState(() {
          hasError = true;
          isButtonActive=true;
        });
        Fluttertoast.showToast(
            msg: "Please try again!",
            fontSize: 16,
            backgroundColor: Colors.orange[100],
            textColor: darkThemeBlue,
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }
  void _login() async{
    showAlertDialog(context);
    Future.delayed(Duration(seconds: 1), () async {
      Fluttertoast.showToast(
          msg: "Otp successfully verified",
          fontSize: 16,
          backgroundColor: Colors.orange[100],
          textColor: darkThemeBlue,
          toastLength: Toast.LENGTH_SHORT);

      Map body = {
        "phone":"${widget.phoneNumber}",
      };

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('otpVerified', true);
      prefs.setString('phoneNumber', number);

      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: "Welcome ${userName}",
          fontSize: 16,
          backgroundColor: Colors.orange[100],
          textColor: darkThemeBlue,
          toastLength: Toast.LENGTH_LONG);
      CustomNavigationHelper.router.go(CustomNavigationHelper.dashboardPath);

      setState(() {

      });
    });
  }
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Loading"),
            )
          ],
        ));

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
  @override
  void dispose() {
    super.dispose();
    countdownTimer!.cancel();
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    String _countDown="$hours:$minutes:$seconds";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffFFFFFF),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              color: Color(0xffFFFFFF),
              child: Column(
                children: [
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Center(child: SvgPicture.asset("assets/images/design.svg",
                          color: Colors.cyan,
                          height: 50.0,
                          width: 100.0,)
                        ),
                      )
                  ),

                  const SizedBox(height: 200),
                  Column(children:  <Widget>[
                    Align(alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 35.0,right: 35),
                        child: Text(
                          'Enter the 6-digit OTP sent to',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(fontWeight: FontWeight.w500, color: Color(0xff333333), fontSize: 18,),
                        ),
                      ),
                    ),
                  ],
                  ),
                  const SizedBox(height: 5),
                  Column(children:  <Widget>[
                    Align(alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Text(
                          '+91$phone_number',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(fontWeight: FontWeight.w500, color: Color(0xff333333), fontSize: 18,),
                        ),
                      ),
                    ),
                  ],
                  ),
                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 45,
                          fieldWidth: 40,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.black12,
                          selectedColor:Colors.black12,
                          selectedFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          activeColor: Colors.black12
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        //do something or move to next screen when code complete
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          if(value.isNotEmpty && value.length>5){
                            setState(() => isButtonActive=true);
                          }else{
                            setState(() => isButtonActive=false);
                          }
                          hasError=false;
                          currentText = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                  (_countDown=="00:00:00")?
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Didn't receive the code? ",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, color: Color(0xff626262),fontSize: 16,),
                        children: [
                          TextSpan(
                            text: " RESEND",
                            recognizer: onTapRecognizer,
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 14, color: Color(0xff989898), fontStyle: FontStyle.normal, decoration: TextDecoration.underline,),
                          )
                        ]),
                  )
                      :
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "OTP Auto Verified In ",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, color: Color(0xff626262),fontSize: 16,),
                        children: [
                          TextSpan(
                            text: "$_countDown",
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 14, color: Color(0xff989898), fontStyle: FontStyle.normal, decoration: TextDecoration.underline,),
                          )
                        ]),
                  ),
                  Column(children:  <Widget>[
                    const SizedBox(height: 48),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0,left: 35.0,right: 35.0),
                      child: SizedBox(
                        width: double.infinity, //
                        height: 46,// <-- match_parent
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.0),

                          child: ElevatedButton(
                            onPressed: isButtonActive ? () {
                              setState(() => isButtonActive=false);
                              otpVerification();
                            } : null,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color(0xff0059B2), disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                              elevation: 5,
                            ),
                            child:  Text('Verify',
                              style: GoogleFonts.lato(fontWeight: FontWeight.w700, color: Color(0xffFFFFFF), fontSize: 23,fontStyle: FontStyle.normal,) ,
                            ),
                            //color: const Color(0xff0059B2),


                          ),
                        ),
                      ),
                    ),



                  ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),




    );
  }
}
