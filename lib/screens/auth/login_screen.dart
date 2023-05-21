import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/student_api_conteoller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
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
            'enter email & password ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailEditingController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email',
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
          SizedBox(height: 10),
          TextField(
            controller: _passwordEditingController,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password',
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
            onPressed: () async => await performLogin(),
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account'),
              TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),

                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.center),
                  child: Text('Create Now!')),
            ],
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context,'/forget_password_screen'),
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.center),
            child: Text('Forget Password' )
          ),
        ],
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      login();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login() async {
    bool status = await StudentApiController().login(
        email: _emailEditingController.text,
        password: _passwordEditingController.text);

    if (status) {
      Navigator.pushReplacementNamed(context, '/users_screen');
    } else {
      showSnakeBar(
          context: context, message: 'Login failed, try again', error: true);
    }
  }
}

// Center(
// child: Image(image: AssetImage('assets/images/candle.gif'),height: double.infinity,fit: BoxFit.cover),
// ),
