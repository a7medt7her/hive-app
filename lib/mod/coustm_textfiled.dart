import 'package:flutter/material.dart';

class CoustmTextfiled extends StatefulWidget {
  Color color;
  String hint;
  int maxLines;
  TextEditingController controller;
  CoustmTextfiled({
    super.key,
    required this.controller,
    required this.color,
    required this.hint,
    required this.maxLines,
  });

  @override
  State<CoustmTextfiled> createState() => _CoustmTextfiled();
}

class _CoustmTextfiled extends State<CoustmTextfiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(style: BorderStyle.solid, color: widget.color),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 2, 2, 2)),
        ),
        hintText: widget.hint,
      ),
    );
  }
}
