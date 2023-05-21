import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twenty_five_flutter_api/api/api_settings.dart';
import 'package:twenty_five_flutter_api/models/Student.dart';
import 'package:twenty_five_flutter_api/prefs/student_preferences_controller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

class StudentApiController with Helpers {
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(ApiSettings.LOHIN);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Student student = Student.fromJson(jsonResponse['object']);
      StudentPreferencesController().saveStudent(student: student);
      return true;
    } else if (response.statusCode == 400) {
      //
    } else {
      //
    }
    return false; // ما دون true راح يرجع false
  }

  Future<bool> logOut() async {
    var url = Uri.parse(ApiSettings.LOGOUT);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferencesController().token,
      HttpHeaders.acceptHeader: 'application/json'
      // هذه حتى لا يرجع خطأ يرجع دائما json بدل html مثل في api التي في ال postman عندما تزيل كلمة
      // Accept
    });

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 4001) {
      await StudentPreferencesController().logOut(); //يقوم بحذف جميع البيانات
      return true;
    } else {
      //
    }

    return false;
  }

  Future<bool> register({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
    required String gender,
  }) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var response = await http.post(url, body: {
      'full_name': fullName,
      'email': email,
      'password': password,
      'gender': gender,
    });

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      showSnakeBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      // انا اجانيresponse.body String
      // وانا حولت  على شكلjsonDecode String
      // و أخذت منه Map json ال  message key
    } else {
      showSnakeBar(
          context: context,
          message: 'something went wrong, please try again',
          error: true);
    }
    return false;
  }

  Future<bool> forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    var url = Uri.parse(ApiSettings.FORGET_PASSWORD);
    var response = await http.post(url, body: {'email': email});
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      showSnakeBar(context: context, message: jsonObject['message']);
      print('Code: ${jsonObject['code']}');
      return true;
    } else if (response.statusCode == 400) {
      var jsonObject = jsonDecode(response.body);
      showSnakeBar(
          context: context, message: jsonObject['message'], error: true);
    } else {
      showSnakeBar(
          context: context,
          message: 'something went wrong, please try again',
          error: true);
    }
    return false;
  }

  Future<bool> resetPassword({
    required BuildContext context,
    required String email,
    required String code,
    required String password,
  }) async {
    var url = Uri.parse(ApiSettings.RESET_PASSWORD);
    var response = await http.post(url, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    });
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      showSnakeBar(context: context, message: jsonObject['message']);
      return true;
    } else if (response.statusCode == 400) {
      var jsonObject = jsonDecode(response.body);
      showSnakeBar(
          context: context, message: jsonObject['message'], error: true);
    } else {
      showSnakeBar(
          context: context,
          message: 'something went wrong, please try again',
          error: true);
    }
    return false;
  }
}
