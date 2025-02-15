import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast;
import 'package:google_fonts/google_fonts.dart';
import '../../../common/helper/navigation_helper.dart';
import '../../../core/common/constants/common_constants.dart';



class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MobileNumberPage> createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  late TextEditingController mobileController;
  String mobileNo = '';
  bool isButtonActive = false;

  RegExp regExp = new RegExp(r"^[0-9]{10}$");
  @override
  void initState() {
    super.initState();
    mobileController = TextEditingController();
    mobileController.addListener(() {
      final isButtonActive= mobileController.text.isNotEmpty;
      setState(() => this.isButtonActive=isButtonActive);
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(

        statusBarColor: Colors.transparent,/* set Status bar color in Android devices. */

        statusBarIconBrightness: Brightness.dark,/* set Status bar icons color in Android devices.*/

        statusBarBrightness: Brightness.dark)/* set Status bar icon color in iOS. */
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xffFFFF),
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
                  Container(
                    child: Column(children:  <Widget>[

                      Align(alignment: Alignment.center,
                        child: Text(
                          'Welcome',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(fontWeight: FontWeight.w700, color: Color(0xff0059B2), fontSize: 24,fontStyle: FontStyle.normal,),
                        ),
                      ),
                      Align(alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25,right:25,top: 20),
                          child: Text(
                            'Enter your mobile number',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500, fontSize: 18, color: Color(0Xff0059B2), fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25,right:25,top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xff828282),)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(left: 11.0,right: 3.0,top: 11.0,bottom:11.0),
                                child: Text('+91', style: TextStyle(
                                  fontFamily: 'Hannari', fontSize: 18, fontWeight: FontWeight.w400,

                                ), ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 0.0,right: 5),
                                child: SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                    color: Color(0xff828282),
                                    thickness: 1,
                                    endIndent: 0,
                                    width: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: TextFormField(
                                    controller: mobileController,
                                    cursorColor: const Color(0xff333333),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                                      hintText: "Mobile number",
                                      focusColor: Color(0xff828282),
                                      hintStyle: GoogleFonts.lato( fontWeight: FontWeight.w400, color: Color(0xff828282), fontSize: 18,fontStyle: FontStyle.normal),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.phone,

                                    style:const TextStyle(
                                      fontWeight: FontWeight.w400, color: Color(0xff333333), fontSize: 18,fontStyle: FontStyle.normal,
                                    ),


                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    ),
                  ),




                  Column(children:  <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20,top: 30,left: 25,right: 25),
                      child: SizedBox(
                        width: double.infinity, //
                        height: 46,// <-- match_parent
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.0),

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color(0xff0059B2), disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                              elevation: 5,
                            ),
                            onPressed: isButtonActive ? () {

                              if(regExp.hasMatch(mobileController.text.trim())){
                                print(mobileController.text.trim());
                                setState(() => isButtonActive=true);

                                number = mobileController.text;
                                CustomNavigationHelper.router.push(CustomNavigationHelper.otpScreenPath);
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Please Enter a Proper Number",
                                    fontSize: 16,
                                    backgroundColor: Colors.orange[100],
                                    textColor: darkThemeBlue,
                                    toastLength: Toast.LENGTH_LONG);
                              }
                            } : null,
                            child:  Text('Sign In',
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

          ],
        ),
      ),




    );
  }
  @override
  void dispose() {
    //_connectivity.disposeStream();
    mobileController.dispose();
    super.dispose();
  }
}
