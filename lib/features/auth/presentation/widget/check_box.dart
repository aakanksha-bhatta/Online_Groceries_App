import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final String categoryName;

  const CheckBox({super.key, required this.categoryName});

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
            checkColor: Colors.white,
            activeColor: Colors.green,
            side: const BorderSide(width: 1.5, color: Color(0xFFB1B1B1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(width: 4),
          Text(
            widget.categoryName,
            style: TextStyle(
              color: isChecked ? Colors.green : const Color(0xFF181725),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
