import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:twenty_five_flutter_api/api/controllers/images_api_controller.dart';
import 'package:twenty_five_flutter_api/models/student_image.dart';

class ImagesGetxController extends GetxController {
  RxList<StudentImage> images = <StudentImage>[].obs;

  // obs : طبعا في نفس الواجهة controller وظيفتها انها تحدث تلقائي و ايضا يستخدم لكي يسمع لعدد كثير من ال
  // getx :controller وظيفتها انها تحدث تلقائي و ايضا يستخدم لكي يسمع لعدد 1 من ال

  ImagesApiController apiController = ImagesApiController();

  static ImagesGetxController get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    read();
    super.onInit();
  }

  Future<void> read() async {
    images.value = await apiController.images();
  }

  Future<bool> delete({required BuildContext context,required int id}) async{
  bool deleted = await apiController.deleteImage(context: context, id: id);
if(deleted){
  images.removeWhere((element) => element.id == id);
}
  return deleted;
  }

//****
// تم وضع برميتر داخل الدالة لانه هذه بي اسمح لها في ui
  // هذه الدالة تمثل مصطلح keylogger منفصل انه يوجد دلة في دالة
  Future<void> upload(
      {required String filePath,
      required ImageUploadResponse imageUploadResponse}) async {
    apiController.uploadImage(
      filePath: filePath,
      imageUploadResponse: (
          {required String massage,
          required bool status,
          StudentImage? studentImage}) {
        if (status) {
          images.add(
              studentImage!); // عملت هيك لانه لما اذهب الى شاشة عرض الصور سوف اجد ان الصورة انضافت عندما اعمل Refresh
        }
// اعملت بناء لل imageUploadResponse و كونته من داخل دالة uploadImage حتى اقدر اخذ ال studentImage و اضيفها على obs list حتى تنعرض list في التطبيق
        // لكي اعمل بناء لل imageUploadResponse نعمل التالي :
        imageUploadResponse(
            status: status, studentImage: studentImage, massage: massage);
      },
    );
  }
}
