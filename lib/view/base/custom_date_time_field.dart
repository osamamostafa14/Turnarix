import 'package:turnarix/Theme/light_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CustomDateTimeField extends StatefulWidget {
  final String? title;
  final Function(DateTime?)? onTextChanged;
  final DateTime? initialDate;
  final Color color;
  final double widthMultiplier;
  final String? hintText;
  const CustomDateTimeField({
    Key? key,
    this.title,
    this.onTextChanged,
    this.initialDate,
    this.color = Colors.black87,
    this.widthMultiplier = 0.8,
    this.hintText,
  }) : super(key: key);

  @override
  _CustomDateTimeFieldState createState() => _CustomDateTimeFieldState();
}

class _CustomDateTimeFieldState extends State<CustomDateTimeField> {
  DateFormat dobFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: DateTimeField(
          initialValue: widget.initialDate,
          style: TextStyle(fontWeight: FontWeight.bold),
          resetIcon: const Icon(Icons.clear),
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0), // old value is 10 modified by assan00942 + makeDateCorner0Size00942
              borderSide: const BorderSide(width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0), // old value is 10 modified by assan00942 + makeDateCorner0Size00942
              borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.8),
                  width: 2),
            ),
          ),
          onChanged: widget.onTextChanged,
          format: dobFormat,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: light.copyWith(
                      colorScheme: const ColorScheme.light().copyWith(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: child!,
                  );
                },
                context: context,
                firstDate: DateTime.utc(1900),
                initialDate: widget.initialDate ?? currentValue ?? DateTime.now(),
                lastDate: DateTime.now());
          },
        ),
      ),
    );
  }
}
