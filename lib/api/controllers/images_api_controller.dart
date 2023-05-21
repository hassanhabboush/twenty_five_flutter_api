import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:twenty_five_flutter_api/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:twenty_five_flutter_api/models/student_image.dart';
import 'package:twenty_five_flutter_api/prefs/student_preferences_controller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

typedef ImageUploadResponse = void Function({
  required bool status,
  StudentImage? studentImage,
  required String massage,
}); //طبعا هذه دالة عادية تأخذ قيم

class ImagesApiController with Helpers {
  // هذه دوال رئيسية :
  Future<List<StudentImage>> images() async {
    var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferencesController().token
      // طلاما يوجد عملية لمستخدم لازم يكون في token
    });

    if (response.statusCode == 200) {
      var dataJsonArray = jsonDecode(response.body)['object'] as List;
      return dataJsonArray.map((e) => StudentImage.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> uploadImage(
      {required String filePath,
      required ImageUploadResponse imageUploadResponse}) async {
    var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('/{id}', ''));
    print('url: $url');
    var request = http.MultipartRequest('POST', url);
    var file = await http.MultipartFile.fromPath('image',
        filePath); //  هنا لمسار الصورة و كلمة image هي ال key الموجودة في ال bady تاعت api
    request.files.add(file);
    request.headers[HttpHeaders.authorizationHeader] = StudentPreferencesController().token;
    // request.fields['names'] = ''; // هذه لارسل او رفع البيانات النصية

    var response = await request.send(); // اعطاء الامر للارسال
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(event);
        imageUploadResponse(
          status: true,
          studentImage: StudentImage.fromJson(jsonResponse['object']),
          massage: jsonResponse['message'],
        );
      } else if (response.statusCode == 400) {
        var jsonResponse = jsonDecode(event);

        imageUploadResponse(
          status: false,
          studentImage: StudentImage.fromJson(jsonResponse['object']),
          massage: jsonResponse['message'],
        );
      }else{
        imageUploadResponse(
          status: false,
          massage: 'Something went wrong!, try again',
        );
      }

    });

    // utf8 : response او ك body فبطر احوله حتى اقدر اقرأ منه و حتى اتعامل معه ك note هو ملف نصي مثل ال
    // keylogger : مصطلح هو :  ان معناها دالة داخل دالة تسمى بالمصطلح هذا
    // ملاحظة ما بينفع ترجع شيء من دالة من نوع void
    // event :  انا ايضا بقرأ منوا ما بنفع ارجعه لانه دالة داخل دالة تحت مصمى مصطلح كلوجرresponse.body هي عبارة عن
    // لو دخلنا في دالة listen تجد treamSubscription<T> listen(void onData(T event)?,
    // StudentImage? : StudentImage? فقط لازم ترجع كامل id وضعنا هذه لانه ما بنفع انرجع
    // else :error يعني سيرفر
    // decoder :String لتحويل من  decoder استخدمناف
    // stream : معناها بث او انبعاث
  }

  Future<bool> deleteImage({required BuildContext context, required int id}) async {
    var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferencesController().token
    });

    if (response.statusCode == 200) {
      showSnakeBar(
          context: context, message: jsonDecode(response.body)['message']);
      return true;
    }
    return false;
  }

//***
}
