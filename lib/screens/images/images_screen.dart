import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twenty_five_flutter_api/api/api_settings.dart';
import 'package:twenty_five_flutter_api/get/images_getx_controller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helpers{
  ImagesGetxController controller = Get.put(ImagesGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('images'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/upload_image_screen'),
              icon: Icon(Icons.cloud_upload_outlined))
        ],
      ),

      /*ملاحظات :
       1. اذا كنت تريد ان تسمع ل GetxController واحد و موجود obc اذا في هذه الحالة راح نستخدم GetxBulider
       1. اذا كنت تريد ان تسمع ل GetxController واحد و مش موجود obc اذا في هذه الحالة راح نستخدم GetBulider
       1. اذا كنت تريد ان تسمع ل اكثر من GetxController واحد و موجود obc اذا في هذه الحالة راح نستخدم Getx
       */

      body: GetX<ImagesGetxController>(
        builder: (controller) {
          if (controller.images.isNotEmpty) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: controller.images.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        ApiSettings.IMAGES_URL + controller.images[index].image,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60,
                          color: Colors.black38,
                          alignment: AlignmentDirectional.centerEnd,
                          child: IconButton(
                              onPressed: () async => deleteImage(id: controller.images[index].id),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade800,
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 80),
                  Text(
                    'No Data',
                    style: TextStyle(color: Colors.grey, fontSize: 22),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> deleteImage({required int id}) async {
    // bool deleted =
        await ImagesGetxController.to.delete(context: context, id: id);
    // print(deleted);
    // String message =
    //     deleted ? 'Image deleted successfully' : 'Failed to delete image';
    //
    // showSnakeBar(context: context, message: message,error: !deleted);
  }
}
