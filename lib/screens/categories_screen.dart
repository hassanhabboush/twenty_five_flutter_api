import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/categories_api_controller.dart';
import 'package:twenty_five_flutter_api/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = <Category>[];
  late Future<List<Category>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = CategoriesApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<List<Category>>(
        future: _future,
        // هنا يعني مين ال future الذي بناءا عليه snapshot التي راح تعمل على ادارة احداثه
        // snapshot = او فارغة data مثل حدث قيد التنفيذ او فشل التنفيذ او انتهى التنفيذ او نجح التنفيذ او رجعت FutureBuilder المعطى ل future هو عبارة عن العنصر المسؤول على ادارة الاحداث المختلفة التي تحصل على
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _categories = snapshot.data!; // حل (1)
            _categories = snapshot.data ?? [];// حل (2)
            return ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text(_categories[index].title),
                  subtitle: Text(_categories[index].productsCount.toString()),
                );
              },
            );
          }else{
            return Column(
              children: [
                Icon(
                  Icons.warning,
                  size: 80,
                ),
                Text(
                  'No Data',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// حل قديم

/*
* import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/categories_api_controller.dart';
import 'package:twenty_five_flutter_api/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = <Category>[];
  late Future<List<Category>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = CategoriesApiController().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<List<Category>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _categories = snapshot.data ?? [];
            return ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text("${_categories[index].name}"),
                  subtitle: Text("${_categories[index].description}"),
                );
              },
            );
          } else {
            return Column(
              children: [
                Icon(
                  Icons.warning,
                  size: 80,
                ),
                Text(
                  'No Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

* */
