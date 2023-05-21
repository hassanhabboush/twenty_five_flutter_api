import 'package:twenty_five_flutter_api/models/user.dart';

class BaseResponse <T>{
  late bool status;
  late String message;
  late List<T> data;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <T>[];
      json['data'].forEach((v) {
        data.add(User.fromJson(v) as T);
      });
    }
  }
}

//************************************

// هنا الشرج للمثال الاول //

/*
* json['data']: jsonArray of object هي عبارة عن
* jsonArray : loop تم عمل عليها
* loop : (v) تعطيني
* (v) : json object عبارة عن
* json object : list و اخزنها في user من نوع  object و يرجع لي User.fromJson(v) كنت امرر له
* json : Map<String, dynamic يأتي على هيئة
* String : ("key") key هو عبارة عن
* dynamic : null or jsonArray or bool or String or number or jsonObjects دائما بكون
* **/



// class BaseResponse {
//  late bool status;
//   late String message;
//   late List<User> data;
//
//
//   BaseResponse.fromJson(Map<String, dynamic> json) {
//     // json : Map<String, dynamic ياتي على هيئة
//     // String : key طبعا هذا هو ال
//     // dynamic :  value طبعا هذا هو ال
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <User>[];
//       json['data'].forEach((v) {
//         // json['data'] : loop اعملت عليها jsonArray of objects غبارة عن
//         // v : user و يخزن داخل user و يرحع user.fromJson امرر هذا الى ال jsonArray of object  هي عبارة عن
//        data!.add(new User.fromJson(v));
//       });
//     }
//   }
//
//
// }

//************************************

// هنا الشرج للمثال الثاني //

// import 'package:twenty_five_flutter_api/models/user.dart';
//
// class BaseResponse <T>{
//   late bool status;
//   late String message;
//   late List<T> data;
//
// // T :حتى نقوم بتمرير اي نوع من البيانات T هنا قمنا بوضع
//   BaseResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <T>[];
//       json['data'].forEach((v) {
//         data.add(User.fromJson(v) as T);
//       });
//     }
//   }
// }