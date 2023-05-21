
class ApiSettings {

  static const _BASE_URL = 'http://demo-api.mr-dev.tech/';
  static const _API_RUI = _BASE_URL + 'api/';
  static const IMAGES_URL = _BASE_URL + 'images/';

  static const USERS = _API_RUI + 'users';
  static const CATEGORIES = _API_RUI + 'categories';
  static const LOHIN = _API_RUI + 'students/auth/login';
  static const LOGOUT = _API_RUI + 'students/auth/logout';
  static const REGISTER = _API_RUI + 'students/auth/register';
  static const FORGET_PASSWORD = _API_RUI + 'students/auth/forget-password';
  static const RESET_PASSWORD = _API_RUI + 'students/auth/reset-password';

  static const IMAGES = _API_RUI + 'student/images/{id}';

}

//************************************

// هنا الشرج //

// class ApiSettings {
//   // تم وضع static حتى اقدر اوصل له من اي اكلاس
//   // تم وضع const لانه ثابت
//
//   static const _API_RUI = 'http://demo-api.mr-dev.tech/api/';
//   static const USERS = _API_RUI + 'users';
//   static const CATEGORIES = _API_RUI + 'categories';
//
// }