import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/student_api_conteoller.dart';
import 'package:twenty_five_flutter_api/screens/auth/reset_password_screen.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  late TextEditingController _emailEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Forget Password',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            'Welcome back...',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          Text(
            'enter email to send reset code! ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailEditingController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Forget Password',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => performPassword(),
            child: Text('Request Code'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performPassword() async {
    if (checkData()) {
      forgetPassword();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await StudentApiController().forgetPassword(
      context: context,
      email: _emailEditingController.text,
    );

    if (status) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: _emailEditingController.text,),
          ),);
    }
  }
}

// Center(
// child: Image(image: AssetImage('assets/images/candle.gif'),height: double.infinity,fit: BoxFit.cover),
// ),
