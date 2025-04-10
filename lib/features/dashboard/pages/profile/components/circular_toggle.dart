import 'package:flutter/material.dart';

class DotToggleButton extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;

  const DotToggleButton({
    Key? key,
    required this.isOn,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5,color: Color(0xff393939)),
            shape: BoxShape.circle,
            color: Colors.transparent
          ),
          child: Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: isOn ? 12 : 0,  // The dot size when ON
              height: isOn ? 12 : 0,
              decoration: BoxDecoration(
                color: isOn ? Color(0xff393939) : Colors.transparent, // Blue dot if ON, no dot if OFF
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}