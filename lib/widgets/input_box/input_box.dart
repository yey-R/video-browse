import 'package:flutter/material.dart';
import 'package:video_browse/utilities/app_scale.dart';
import 'package:video_browse/utilities/constants.dart';

class InputBox extends StatefulWidget {
  final Function fun;
  final String hint;
  final int maxLength;
  const InputBox({
    Key? key,
    required this.fun,
    required this.hint,
    required this.maxLength,
  }) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 2.9 * AppScale.widthMultiplier,
        vertical: 1.1 * AppScale.heightMultiplier,
      ),
      child: TextField(
        maxLength: widget.maxLength,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (value) {
          widget.fun(
            value,
          );
        },
        style: const TextStyle(
          color: kColorPrimary,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          filled: true,
          fillColor: Colors.white,
          counterStyle: const TextStyle(
            color: kColorInactive,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(1.1 * AppScale.heightMultiplier),
          ),
        ),
      ),
    );
  }
}
