import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String text;
  final AssetImage? background;
  const CardButton({Key? key, required this.text, this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return Container(
      height: width / 2.8,
      // width: width / 3.5,
      color: Colors.white,
      decoration: BoxDecoration(
          image: (background == null) ? null : DecorationImage(
            image: background!,
            fit: BoxFit.fill,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(text),
    );
  }
}
