import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars_app/ui/providers/page_provider_riverpod.dart';
import 'package:star_wars_app/ui/widgets/media_card.dart';

class ContentArea extends ConsumerWidget {
  const ContentArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    final _contentList = ref.watch(contentList.state).state;

    return ListView.builder(
      itemCount: _contentList.length,
      itemBuilder: (context, index) {
        return MediaCard(entity: _contentList[index]);
      },
    );
  }
// }
