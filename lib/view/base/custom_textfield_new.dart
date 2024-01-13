
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldNew extends StatefulWidget {
  final String? hintText;
  final String? title;

  //final IconData icon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final bool isPassword;

  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  CustomTextFieldNew(
      {
        this.hintText,
        this.title,
        this.onChanged,
        this.validator,
        this.initialValue,
        this.isPassword = false,
        this.controller,
        this.maxLines = 1,
        this.minLines = 1,
        this.maxLength,
        this.inputFormatters,
        this.keyboardType = TextInputType.text,
        this.autoFocus = false,
        this.focusNode,
        this.prefixIcon,
      });

  @override
  _CustomTextFieldNewState createState() => _CustomTextFieldNewState();
}

class _CustomTextFieldNewState extends State<CustomTextFieldNew> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        obscureText: widget.isPassword ? _passwordVisible : false,
        initialValue: widget.initialValue,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black38,
              ),
              onPressed: () => setState(() {
                _passwordVisible = !_passwordVisible;
              }))
              : null,
          // labelText: widget.hintText,
          labelText: widget.title,
          labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          hintText: widget.hintText, // hassan00942
          alignLabelWithHint: true, // hassan00942
          contentPadding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.white70 // why border color not changing
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.white70,
                width: 2),
          ),
          // prefixIcon: widget.prefixIcon,
          prefix: widget.prefixIcon,
        ),
      ),
    );
  }

}
