import 'package:shared_preferences/shared_preferences.dart';
import 'package:twenty_five_flutter_api/models/Student.dart';

class StudentPreferencesController {
  // هذا بناء singleton
  static final StudentPreferencesController _instance =
      StudentPreferencesController._internal();

  late SharedPreferences _sharedPreferences;

  factory StudentPreferencesController(){
    return _instance;
  }

  StudentPreferencesController._internal();

  Future<void> intSharedPreferences() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //*************************
  // هذه الدالة تقوم بحفظ بيانات المستخدم و بدنا نعرف هل المستخدم مسجل الدخول ام لا لانه اذا كان مسجل دخول يذهب مباشرتا الى ال home

  Future<void> saveStudent ({required Student student}) async {
    _sharedPreferences.setBool('logged_in', true);
    _sharedPreferences.setInt('id', student.id);
    _sharedPreferences.setString('fullName', student.fullName);
    _sharedPreferences.setString('email', student.email);
    _sharedPreferences.setString('gender', student.gender);
    _sharedPreferences.setString('token', "Bearer ${student.token}");
    _sharedPreferences.setBool('isActive', student.isActive);
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false; // هذا برجع  null اذا رجع null نقول له خود رجع false (طبعا راح يرجع  false اذا كانت ال (logged_in)key لم تخزن بأول عملية قراءة ممكن تكون )

  String get token => _sharedPreferences.getString('token') ?? ''; // طبعا ما راح ارجع فارغ الا ان اكون عامل  login و بالتالي ما راح يعمل مشكلة

  Future<bool> logOut() async{
    return await _sharedPreferences.clear(); //يقوم بحذف جميع البيانات

  }
 }
