import 'package:flutter/material.dart';
import 'package:video_browse/utilities/constants.dart';

class InputBox extends StatefulWidget {
  final Function fun;
  final String hint;

  const InputBox({
    Key? key,
    required this.fun,
    required this.hint,
  }) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  dynamic flag;
  @override
  void initState() {
    super.initState();
    flag = widget.hint == "Title";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      child: TextField(
        maxLength: flag ? 30 : 250,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (value) {
          widget.fun(
            value,
            flag,
          );
        },
        style: const TextStyle(
          color: kColorPrimary,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.done,
            color: Colors.green,
          ),
          hintText: widget.hint,
          filled: true,
          fillColor: Colors.white,
          counterStyle: const TextStyle(
            color: kColorInactive,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
