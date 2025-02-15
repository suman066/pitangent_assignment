import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;



const darkerThemeBlue= Color.fromRGBO(6, 28, 43, 1);

const darkThemeBlue= Color.fromRGBO(8, 35, 54, 1.0);

const lightThemeBlue= Color.fromRGBO(16, 51, 75, 1.0);

const lightTextBlue= Color.fromRGBO(78, 121, 151, 1.0);

const lightTextGrey= Color.fromRGBO(212, 208, 208, 0.33);

const textCol=Colors.white70;

const circularBGCol=Colors.orange;
var circularStrokeCol=Colors.orange[50];
const double strokeWidth=4;

const FontWeight font_bold = FontWeight.w600;

const orangeCol=Color.fromRGBO(227, 97, 38, 1.0);
const lightOrangeCol=Color.fromRGBO(227, 97, 38, 0.5);

const darkOrangeCol=Color.fromRGBO(193, 81, 31, 1.0);

final String _baseUrl = "http://doctors.code-dev.in/api/";


// const mapAPIKey = "AIzaSyC6hMR5kMX8Y5M0BgxCzZji81nhxf_uLmM";
const mapAPIKey = "AIzaSyAwQ3Gm7MIQ61LSG4u2s6XBuZyLZMj47CE"; //latest 09/06/2021




// Pick Drop Variables---------------------
// ----------------------------------------
String pickupAddress="";
String pickupLandMark="";
String destinationLandMark="";
String destinationAddress="";
String sName="";
String sPhone="";
String rName="";
String rPhone="";
String productName="";
String productRemarks="";
String productWeight="";
String productPrice="";
double pickUpLat=0;
double pickUpLong=0;
double dropLat=0;
double droplong=0;
String dateAndTime="";
String dateAndTime2="";
String dateAndTimeFormated="";
String dateAndTimeFormated2="";
String productType="";
bool productNameVisibility1=false;
bool extraPersonRequired=false;
bool productPaymentRequired=false;
String paymentType="Cash Payment";
String vehicleType="Two-Wheeler";
int vehicleIndex=0;
int paymentUserIndex=0;
String paymentUser="Sender";
int productPaymentUserIndex=0;
String productPaymentUser="Sender";
String baseImage = "";
String baseImage2 = "";
String fileName = "";
String orderremarks = '';
String imageurl='';
// ----------------------------------------


double screenHeight=0;
double screenWidth=0;
bool registeredUser = false;
String token = '';
String number = '';
int userid = 0;
String shopName = '';
String email = '';
String shopNumber = '';
String registerMessage = '';
String userName = '';
String shopPhone = '';
String refferalCode = '';
bool validDoctor = true;
String doctorSearch = '';




double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}