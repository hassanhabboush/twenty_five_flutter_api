import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/student_api_conteoller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _fullNameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  String _gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameEditingController.dispose();
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
            'Create account...',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          Text(
            'enter bellow data ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _fullNameEditingController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Full name',
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
            controller: _emailEditingController,
            keyboardType: TextInputType.text,
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
          SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Male'),
                    value: 'M',
                    groupValue: _gender,
                    onChanged: (String? value) {
                      if(value != null){
                        setState(() {
                          _gender = value;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Famale'),
                    value: 'F',
                    groupValue: _gender,
                    onChanged: (String? value) {
                      if(value != null){
                        setState(() {
                          _gender = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await performRegister(),
            child: Text('Register'),
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

  Future<void> performRegister() async {
    if (checkData()) {
      register();
    }
  }

  bool checkData() {
    if (_fullNameEditingController.text.isNotEmpty &&
        _emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    
    showSnakeBar(context: context, message: 'Enter required data',error: true);
    
    return false;
  }

  Future<void> register() async {
    bool status = await StudentApiController().register(
        context: context,
        fullName: _fullNameEditingController.text,
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
        gender: _gender);

    if (status) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    } else {
      showSnakeBar(
          context: context, message: 'Login failed, try again', error: true);
    }
  }
}

// Center(
// child: Image(image: AssetImage('assets/images/candle.gif'),height: double.infinity,fit: BoxFit.cover),
// ),
