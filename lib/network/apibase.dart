import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'app_exceptions.dart';

class ApiBaseHelper {

  final String _baseUrl = "http://doctors.code-dev.in/api/";
  final String baseUrl = "http://doctors.code-dev.in/api/";


  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    print(_baseUrl + url);
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print(jsonEncode(responseJson));
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> getWithHeader(String url, String token) async {
    //print('Api Post, url $_baseUrl+url');
    print(_baseUrl+url);
    print('Api token, token $token');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url),headers: {"Authorization": token});
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(responseJson);
    return responseJson;
  }

  Future<dynamic> post(String url, Map body) async {
    print('Api Post, url $url');
    print(_baseUrl + url);
    print(jsonEncode(body));
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(jsonEncode(responseJson));
    return responseJson;
  }

  Future<dynamic> postWithHeader(String url, Map body,String token) async {
    //print('Api Post, url $_baseUrl+url');
    print(_baseUrl+url);
    print(jsonEncode(body));
    print(token);
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: jsonEncode(body),headers: {"Authorization": token,"Content-Type": "application/json"});
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(responseJson);
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');

    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      print(response.body.toString());
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 800:
      print(response.body.toString());
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 201:
      print(response.body.toString());
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:

    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      print(response.body.toString());
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
