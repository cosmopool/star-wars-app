import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars_app/ui/widgets/buttons_area_widget.dart';

class MediaSelectionPage extends ConsumerWidget {
  const MediaSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: const [
          ButtonsArea(),
        ContentArea(),
        ],
      ),
    );
  }
}
