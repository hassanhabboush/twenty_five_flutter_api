import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twenty_five_flutter_api/api/api_settings.dart';
import 'package:twenty_five_flutter_api/models/base_response.dart';
import 'package:twenty_five_flutter_api/models/user.dart';

class UsersApiController {
  Future<List<User>> getUsers() async {
    var url = Uri.parse(ApiSettings.USERS);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      BaseResponse<User> baseResponse = BaseResponse.fromJson(jsonDecode(
          response.body));
      return baseResponse.data;

    } else if (response.statusCode == 400) {
    } else {
      //
    }
    return [];
  }
}
//************************************
// هنا الشرح للمثال الاول

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:twenty_five_flutter_api/api/api_settings.dart';
// import 'package:twenty_five_flutter_api/models/base_response.dart';
// import 'package:twenty_five_flutter_api/models/user.dart';
//
// class UsersApiController {
//   Future<List<User>> getUsers() async {
//     // تم وضع list of user لانه انا لست محتاج كل BaseResponse فقط انا محتاج list الخاصة في ال user الي اسمها هنا data يعني اسم list
//     var url = Uri.parse(ApiSettings.USERS); //هنا يحول النص الى url
//     var response = await http.get(
//         url); // راح يرجع  response من نوع get // طبعا تعد هذه العملية Future لازم نضع async and await
//
//     //BaseResponse قمنا في هذه العملية بتفريخ الداتا التي وصلتنا و انعبيها في
//     if (response.statusCode == 200) {
//       BaseResponse baseResponse = BaseResponse.fromJson(jsonDecode(
//           response.body)); // هنا اجاني json من السيرفر معمول له عملية enCoding
//       // enCoding = (String) الى نص  jsonResponse  هي عملية تحويل ال
//       //  enCoding x jsonDecode : (عكس)
//       // var jsonArray = baseResponse['data'];
//       return baseResponse
//           .data; //  هنا قمنا بترجيع  list هنا مسماه (data) فقط و ليس base كله
//     } else if (response.statusCode == 400) {
//       //ممكن هنا تظهر رسائل خطأ هنا
//     } else {
//       // هما برجع error يعني 500
//       //
//     }
//     return []; //هنا قمنا بترجيع EmptyArray يعني (Array فارغة)
//   }
// }
//

//************************************
// هنا الشرح للمثال الثانية

// class UsersApiController {
//   Future<List<User>> getUsers() async {
//     var url = Uri.parse(ApiSettings.USERS);
//     var response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       BaseResponse<User> baseResponse = BaseResponse.fromJson(jsonDecode(
//           response.body)); // هنا اجاني json من السيرفر معمول له عملية enCoding
//       return baseResponse.data;  //  هنا data اصبحت من نوع user لكن بدون ما تضع <User> سوف تبقى dynamic data
//
//     } else if (response.statusCode == 400) {
//     } else {
//       //
//     }
//     return [];
//   }
// }
