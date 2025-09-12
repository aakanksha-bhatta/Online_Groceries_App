import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final String categoryName;
  final bool isChecked;
  final Function(bool?) onChanged;

  const CheckBox({
    super.key,
    required this.categoryName,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            checkColor: Colors.white,
            activeColor: Colors.green,
            side: const BorderSide(width: 1.5, color: Color(0xFFB1B1B1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            categoryName,
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
