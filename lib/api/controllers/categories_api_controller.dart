import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twenty_five_flutter_api/api/api_settings.dart';
import 'package:twenty_five_flutter_api/models/category.dart';

class CategoriesApiController {
  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiSettings.CATEGORIES);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();
    } else if (response.statusCode == 400) {
      //
    } else {
      //
    }
    return [];
  }
}


//************************************

// هنا الشرج //

// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:twenty_five_flutter_api/api/api_settings.dart';
// import 'package:twenty_five_flutter_api/models/category.dart';
//
// class CategoriesApiController {
//
//   Future<List<Category>> getCategories() async {
//     var url = Uri.parse(ApiSettings.CATEGORIES);
//     var response = await http.get(url);
//
//     if(response.statusCode == 200){
//       var jsonResponse = jsonDecode(response.body);
//       var jsonArray = jsonResponse['data'] as List;
//       return jsonArray.map((jsonObject) => Category.fromJson(jsonObject)).toList();
//       // jsonArray.map((jsonObject) => Category.fromJson(jsonObject)).toList(); : list و تعبيهم في Category الى map من Category و تحول كل list تقوم بانشاء
//       // jsonArray.map : list موجود في (object) على كل عنصر loop تعمل
//       // كل حاجة موجودة في jsonResponse تكون dynamic
//       // data : list الخاص ب key هذا اسم ال
//       /*
//     * jsonResponse : String -> Map
//     * Map : json تمثل ال
//     * قمنا حولنا من enDecode الى decode حتى يتحول الى map
//     * وضعنا response.body حتى نحول من String الى map
//     * */
//       //
//     }else if(response.statusCode == 400){
//       //
//     }else {
//       //
//     }
//     return [];
//   }
// }
