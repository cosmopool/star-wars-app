import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars_app/ui/widgets/card_button.dart';

class ButtonsArea extends ConsumerWidget {
  const ButtonsArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Row(
      children: const [
        CardButton(text: 'Characters'),
        CardButton(text: 'Movies'),
        CardButton(text: 'Favorites'),
      ],
    );
  }
}
