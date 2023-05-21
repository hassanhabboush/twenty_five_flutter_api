import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/users_api_controller.dart';
import 'package:twenty_five_flutter_api/models/user.dart';
import 'package:twenty_five_flutter_api/prefs/student_preferences_controller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

class UsersScreen extends StatefulWidget {
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> with Helpers{
  List<User> _users = <User>[];
  late Future<List<User>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = UsersApiController().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            onPressed: () async => await logOut(),
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/images_screen') ,
            icon: Icon(Icons.image),
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _users = snapshot.data ?? [];
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                      "${_users[index].firstName} ${_users[index].lastName}"),
                  subtitle: Text(_users[index].email),
                  trailing: Icon(Icons.arrow_forward_ios),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  Future<void> logOut() async{
    bool status = await StudentPreferencesController().logOut();
    if(status){
      Navigator.pushReplacementNamed(context, '/login_screen');
    }else{
      showSnakeBar(context: context, message: 'Logout failed, try again' ,error : true);
    }
  }

}

//************************************

// هنا الشرج //

/* j : (الطلب) request كيف تنفيذ ال
* f اذاً هي عملية طلب ل مجموعة بيانات بناءا على حدث مستقبلي  futuer اولا : صح انه
* */

//
// import 'package:flutter/material.dart';
// import 'package:twenty_five_flutter_api/api/controllers/users_api_controller.dart';
// import 'package:twenty_five_flutter_api/models/user.dart';
//
// class UsersScreen extends StatefulWidget {
//   @override
//   State<UsersScreen> createState() => _UsersScreenState();
// }
//
// class _UsersScreenState extends State<UsersScreen> {
//   List<User> _users = <User>[];
//   late Future<List<User>>
//   _future; // هنا ذهبنا لملف users_api_controller و نسخنا Future<List<User>> تم نسخه لانه request يقوم بترجيع Future<List<User>>
//
//   @override
//   void initState() {
//     //  هنا قمت باعطاء الاذن لعملية طلب البيانات يعني اعطاته الاذن يطلب البيانات من api in list user
//     // TODO: implement initState
//     super.initState();
//     _future = UsersApiController().getUsers();
//     // getUsers() : Future<List<User>> هذه بترجع
//     // _future : Future<List<User>> هي عبارة عن
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Users'),
//       ),
//       body: FutureBuilder<List<User>>(
//         future: _future,
//         //future  : Future<List<User>> على شان هيك اعطناه Future<List<User>> بترجع
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             // _users = snapshot.data!; // مثال (1)
//             _users = snapshot.data ?? []; // مثال (2)
//             return ListView.builder(
//               itemCount: _users.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text("${_users[index].firstName} ${_users[index].lastName}"),
//                   subtitle: Text(_users[index].email),
//                   trailing: Icon(Icons.arrow_forward_ios),
//                 );
//               },
//             );
//           } else {
//             return Column(
//               children: [
//                 Icon(
//                   Icons.warning,
//                   size: 80,
//                 ),
//                 Text(
//                   'No Data',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 )
//               ],
//             );
//           }
//           // اذا وضعنا الشرط الثاني في الاول لا نطر نضع !
//           // !: وضعنا ! لل data حتى لا تحدث مشكلة بعد تحقيق الشرط من قبل snapshot.hasData
//           // هنا تفحص ان hasData لا تساوي null
//           //snapshot.data : list<user> من نوع data طبعا هنا
//           //hasData : data != null; ( null لا تساوي data يعني) تساوي
//           //    ...fراح اترجع fConnectionState.waiting    حالة الاتصال الخاصة به تساويg اذا كانت snapshot
//           // snapshot  :الان request هي عبارة عن العنصر المتحكم في حالة ال
//         },
//       ), //هذه عملية مستقبلية من نوع list<User>y
//     );
//   }
// }
//
// /* j : (الطلب) request كيف تنفيذ ال
// * f اذاً هي عملية طلب ل مجموعة بيانات بناءا على حدث مستقبلي  futuer اولا : صح انه
// * */
