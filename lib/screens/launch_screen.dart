import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/prefs/student_preferences_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
    String routeName = StudentPreferencesController().loggedIn ? '/users_screen' : '/login_screen';
    Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('Api',style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
