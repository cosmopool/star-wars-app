import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars_app/ui/pages/official_site.dart';
import 'package:star_wars_app/ui/providers/page_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentPage = ref.watch(currentPage.state).state;
    final _webViewIsActive = ref.watch(webViewIsActive.state).state;
    final setWebView = ref.read(webViewIsActive.state);
    const webViewPage = OfficialSitePage();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: TextButton(
            child: const Text('site oficial'),
            onPressed: () => setWebView.state = !_webViewIsActive,
          ),
          // title: const Text('Star wars'),
          actions: [
            CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              child: const Text('Avatar'),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Consumer(builder: (context, ref, _) {
          return _webViewIsActive ? webViewPage : _currentPage;
        }),
      ),
    );
  }
}
