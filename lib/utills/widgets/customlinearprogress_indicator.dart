import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double progress; 

  const CustomLinearProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: LinearProgressIndicator(
          value: progress,
          color: Colors.red,
          backgroundColor: Color.fromARGB(255, 241, 235, 235),
          minHeight: 15.0,
        ),
      ),
    );
  }
}
