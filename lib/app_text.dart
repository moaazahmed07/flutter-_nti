import 'package:flutter/material.dart';
class AppText extends StatefulWidget {


  AppText({super.key , required  this.label});
  final String label;
  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {

    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: 'rebecca@home.io',
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
