import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = false;

  Color get _buttonColor => liked ? Colors.red : Colors.black;
  IconData get _icon => liked ? Icons.thumb_up : Icons.thumb_up_outlined;
  String get _label => liked ? "Liked" : "Like";

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          liked = !liked;
        });
      },
      icon: Icon(_icon, color: _buttonColor),
      label: Text(_label, style: TextStyle(color: _buttonColor)),
    );
  }
}