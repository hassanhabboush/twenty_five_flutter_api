import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/prefs/student_preferences_controller.dart';
import 'package:twenty_five_flutter_api/screens/auth/forget_password_screen.dart';
import 'package:twenty_five_flutter_api/screens/auth/login_screen.dart';
import 'package:twenty_five_flutter_api/screens/auth/register_screen.dart';
import 'package:twenty_five_flutter_api/screens/categories_screen.dart';
import 'package:twenty_five_flutter_api/screens/images/images_screen.dart';
import 'package:twenty_five_flutter_api/screens/images/upload_image_screen.dart';
import 'package:twenty_five_flutter_api/screens/launch_screen.dart';
import 'package:twenty_five_flutter_api/screens/users_screen.dart';


// ذهبنا عنا لل main حتى نعرف كلاس singleton
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StudentPreferencesController().intSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
       '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
       '/register_screen': (context) => RegisterScreen(),
        '/forget_password_screen': (context) => ForgetPasswordScreen(),
        // '/reset_password_screen': (context) => ResetPasswordScreen(),
        '/users_screen': (context) => UsersScreen(),
       '/category_screen': (context) => CategoriesScreen(),
       '/images_screen': (context) => ImagesScreen(),
       '/upload_image_screen': (context) => UploadImageScreen(),
      },
    );
  }
}
