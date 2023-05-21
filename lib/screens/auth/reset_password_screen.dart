import 'package:flutter/material.dart';
import 'package:twenty_five_flutter_api/api/controllers/student_api_conteoller.dart';
import 'package:twenty_five_flutter_api/utils/helpers.dart';
import 'package:twenty_five_flutter_api/widgets/code_text_fielde.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with Helpers {
  String? _code;

  late TextEditingController _passwordEditingController;
  late TextEditingController _passwordConfirmationEditingController;

  late TextEditingController _firstCodeEditingController;
  late TextEditingController _secondCodeEditingController;
  late TextEditingController _thirdCodeEditingController;
  late TextEditingController _fourthCodeEditingController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordEditingController = TextEditingController();
    _passwordConfirmationEditingController = TextEditingController();

    _firstCodeEditingController = TextEditingController();
    _secondCodeEditingController = TextEditingController();
    _thirdCodeEditingController = TextEditingController();
    _fourthCodeEditingController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordEditingController.dispose();
    _passwordConfirmationEditingController.dispose();
    _firstCodeEditingController.dispose();
    _secondCodeEditingController.dispose();
    _thirdCodeEditingController.dispose();
    _fourthCodeEditingController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(color: Colors.black)),
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
            'enter code & new password',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CodeTextField(
                  codeEditingController: _firstCodeEditingController,
                  focusNode: _firstFocusNode,
                  onChanded: (String value) {
                    if (value.isNotEmpty) _secondFocusNode.requestFocus();
                    // معناها اذا first مش فاضي انقلني الى الثاني
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  codeEditingController: _secondCodeEditingController,
                  focusNode: _secondFocusNode,
                  onChanded: (String value) {
                    if (value.isNotEmpty)
                      _thirdFocusNode.requestFocus();
                    else
                      _firstFocusNode.requestFocus();
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  codeEditingController: _thirdCodeEditingController,
                  focusNode: _thirdFocusNode,
                  onChanded: (String value) {
                    if (value.isNotEmpty)
                      _fourthFocusNode.requestFocus();
                    else
                      _secondFocusNode.requestFocus();
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  codeEditingController: _fourthCodeEditingController,
                  focusNode: _fourthFocusNode,
                  onChanded: (String value) {
                    if (value.isNotEmpty) _thirdFocusNode.requestFocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: _passwordEditingController,
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
          TextField(
            controller: _passwordConfirmationEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password Confirmation',
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
            onPressed: () async => performResetPassword(),
            child: Text('Reset Password'),
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

  Future<void> performResetPassword() async {
    if (checkData()) {
      resetPassword();
    }
  }

  bool checkData() {
    if (checkCode()) {
      //    اذا checkData لم تحقق الشرط سوف يخرج للمستخدم رسلتها الخاصة و يتم تجاهل checkPassword اما اذا checkData حققك الشرط و فشلت checkPassword سوف يظهر رسلت checkPassword
      if (checkPassword()) return true;
    }
    // showSnakeBar(
    //     context: context, message: 'Enter required data!', error: true);

    return false;
  }

  bool checkPassword() {
    if (_passwordEditingController.text.isNotEmpty &&
        _passwordConfirmationEditingController.text.isNotEmpty) {
      if (_passwordEditingController.text ==
          _passwordConfirmationEditingController.text) {
        return true; // هنا اذا كانت الامور تمام برجع صح
      }
      showSnakeBar(
          context: context,
          message: 'Password Confirmation error!',
          error: true);
      // اذا كان في مشكلة في ال password
    }
    return false; // هنا اذا كان ما في كود
  }

  bool checkCode() {
    if (_fourthCodeEditingController.text.isNotEmpty &&
        _secondCodeEditingController.text.isNotEmpty &&
        _thirdCodeEditingController.text.isNotEmpty &&
        _fourthCodeEditingController.text.isNotEmpty) {
      _code = _fourthCodeEditingController.text +
          _secondCodeEditingController.text +
          _thirdCodeEditingController.text +
          _fourthCodeEditingController.text;
      return true;
    }
    showSnakeBar(context: context, message: 'Enter sent code!', error: true);
    return false;
  }

  Future<void> resetPassword() async {
    bool status = await StudentApiController().resetPassword(
        context: context,
        email: widget.email,
        code: _code!,
        password: _passwordEditingController.text);

    if (status) {
      Navigator.pop(context); // هنا راح يرجعني على login
    }
  }
}

// Center(
// child: Image(image: AssetImage('assets/images/candle.gif'),height: double.infinity,fit: BoxFit.cover),
// ),
