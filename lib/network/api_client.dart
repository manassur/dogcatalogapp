// ignore_for_file: avoid_debugPrint

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/responses/generic_response.dart';
import 'app_exceptions.dart';

class ApiClient {
  final httpClient = http.Client();

  Future<Map<String,String>> getHeaders() async{
    var headers = <String, String>{
      "Accept": "text/plain",
      'Content-Type': "application/json-patch+json",
      // 'Authorization':authorization??''
      // authorization??''
    };

    return headers;
  }

  Future<dynamic> get(String url) async {
    var headers = await getHeaders();
    debugPrint('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url),headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api get recieved!');
    return responseJson;
  }

  Future<dynamic> getWithHeaders(String url) async {
    debugPrint('Api Get, url $url');
    var headers = await getHeaders();

    var responseJson;
    try {
      final response = await http.get(Uri.parse(url),headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api get recieved!');
    return responseJson;
  }
  
  Future<dynamic> postForm(String url, Map body) async {
    debugPrint('Api Post, url :' + url);
    debugPrint('parameters:' + body.toString());
    var headers = await getHeaders();

    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), body: json.encode(body),headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api post.');
    debugPrint("responsejson" + responseJson.toString());

    return responseJson;
  }

  Future<dynamic> postFormWithHeader(String url, Map body) async {
    debugPrint('Api Post, url :' + url);
    debugPrint('parameters:' + body.toString());

    var headers = await getHeaders();

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api post.');
    debugPrint("responsejson" + responseJson.toString());

    return responseJson;
  }

  Future<dynamic> postToPhp(String url, Map body) async {
    debugPrint('Api Post, url :' + url);
    debugPrint('parameters:' + body.toString());

    var headers = await getHeaders();

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body:body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api post.');
    debugPrint("responsejson" + responseJson.toString());

    return responseJson;
  }


  Future<dynamic> postFormWithCustomHeader(String url, Map body, customHeader) async {
    debugPrint('Api Post, url :' + url);
    debugPrint('parameters:' + body.toString());
    var headers = await getHeaders();

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api post.');
    debugPrint("responsejson" + responseJson.toString());

    return responseJson;
  }


  Future<dynamic> post(String url, String body) async {
    debugPrint('parameters:' + body.toString());
    var headers = await getHeaders();

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: body,headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api post.');
    debugPrint(responseJson.toString());

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    debugPrint('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api put.');
    debugPrint(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    debugPrint('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('api delete.');
    return apiResponse;
  }

  dynamic _returnResponse(http.Response response) {
    debugPrint("response :" + response.body.toString());

    var responseJson = response.body;

    debugPrint("response :" + responseJson.toString() +' status code:' +response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 302:
        return responseJson;
      case 400:
        if(response.body.contains("\"message\":")){
          GenericResponse genericResponse =
          GenericResponse.fromJson(jsonDecode(response.body));
          debugPrint(genericResponse.message);
          throw BadRequestException(genericResponse.message);
        }else{
          throw BadRequestException(response.body);
        }
      case 401:
        if(response.body.contains("\"message\":")){
          GenericResponse genericResponse =
          GenericResponse.fromJson(jsonDecode(response.body));
          debugPrint(genericResponse.message);
          throw BadRequestException(genericResponse.message);
        }else{
          throw BadRequestException("oops an error occured");
        }

      case 403:
        GenericResponse genericResponse =
        GenericResponse.fromJson(jsonDecode(response.body));
        debugPrint(genericResponse.message);
        if(response.body.contains("\"message\":")){
          GenericResponse genericResponse =
          GenericResponse.fromJson(jsonDecode(response.body));
          debugPrint(genericResponse.message);
          throw BadRequestException(genericResponse.message);
        }else{
          throw UnauthorisedException('Error occured while Communicating with Server with StatusCode : ${response.statusCode}');
        }

      case 404:
        if(response.body.contains("\"message\":")){
          GenericResponse genericResponse =
          GenericResponse.fromJson(jsonDecode(response.body));
          debugPrint(genericResponse.message);
          throw BadRequestException(genericResponse.message);
        }else{
          throw BadRequestException("oops an error occured");
        }
      case 500:
        throw BadRequestException('Could not communicate with server at this time.');
      default:
        throw FetchDataException(
            'Error occured while Communicating with Server with StatusCode : ${response.statusCode}');
    }
  }
}
