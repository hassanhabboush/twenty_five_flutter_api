import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
  // const CodeTextField({
  //   super.key,
  //   required TextEditingController firstCodeEditingController,
  //   required FocusNode firstFocusNode,
  // }) : _firstCodeEditingController = firstCodeEditingController, _firstFocusNode = firstFocusNode;

  final TextEditingController codeEditingController;
  final FocusNode focusNode;
  final void Function(String value) onChanded;

  CodeTextField({
    required this.codeEditingController,
    required this.focusNode,
    required this.onChanded,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: codeEditingController,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: onChanded,
      maxLines: 1,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
